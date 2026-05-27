#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "net/http"
require "pathname"
require "uri"

ROOT = Pathname.new(__dir__).parent
FORMULA_PATH = Pathname.new(ENV.fetch("EXEC_ECS_FORMULA_PATH", ROOT/"Formula/exec-ecs.rb"))
RELEASE_URL = URI("https://api.github.com/repos/DigitalTolk/exec-ecs/releases/latest")
ASSETS = {
  "darwin_arm64" => "exec-ecs_Darwin_arm64.tar.gz",
  "darwin_x86_64" => "exec-ecs_Darwin_x86_64.tar.gz",
  "linux_arm64" => "exec-ecs_Linux_arm64.tar.gz",
  "linux_x86_64" => "exec-ecs_Linux_x86_64.tar.gz",
}.freeze

def get_json(uri)
  request = Net::HTTP::Get.new(uri)
  request["Accept"] = "application/vnd.github+json"
  request["X-GitHub-Api-Version"] = "2022-11-28"
  request["User-Agent"] = "DigitalTolk-homebrew-tools"
  request["Authorization"] = "Bearer #{ENV.fetch("GITHUB_TOKEN")}" if ENV["GITHUB_TOKEN"]

  response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
    http.request(request)
  end

  abort "GitHub API returned #{response.code}: #{response.body}" unless response.is_a?(Net::HTTPSuccess)

  JSON.parse(response.body)
end

release = get_json(RELEASE_URL)
tag = release.fetch("tag_name")
version = tag.delete_prefix("v")

assets_by_name = release.fetch("assets").to_h { |asset| [asset.fetch("name"), asset] }
digests = ASSETS.transform_values do |asset_name|
  asset = assets_by_name[asset_name]
  abort "No #{asset_name} asset found on release #{tag}" unless asset

  digest = asset["digest"].to_s
  abort "Release asset #{asset_name} has no sha256 digest" unless digest.start_with?("sha256:")

  digest.delete_prefix("sha256:")
end

content = FORMULA_PATH.read
current_version = content[/version "([^"]+)"/, 1]
abort "Could not find current formula version in #{FORMULA_PATH}" unless current_version

puts "latest exec-ecs release: #{tag}"
puts "current formula version: #{current_version}"

def replace_once(content, pattern, replacement, label)
  abort "Could not find #{label}; formula layout changed" unless content.match?(pattern)

  updated = content.sub(pattern, replacement)

  updated
end

updated = replace_once(content, /version "[^"]+"/, %(version "#{version}"), "version")
updated = replace_once(
  updated,
  %r{(exec-ecs_Darwin_arm64\.tar\.gz"\n\s+sha256 ")[a-f0-9]{64}(")},
  "\\1#{digests.fetch("darwin_arm64")}\\2",
  "Darwin arm64 sha256",
)
updated = replace_once(
  updated,
  %r{(exec-ecs_Darwin_x86_64\.tar\.gz"\n\s+sha256 ")[a-f0-9]{64}(")},
  "\\1#{digests.fetch("darwin_x86_64")}\\2",
  "Darwin x86_64 sha256",
)
updated = replace_once(
  updated,
  %r{(exec-ecs_Linux_arm64\.tar\.gz"\n\s+sha256 ")[a-f0-9]{64}(")},
  "\\1#{digests.fetch("linux_arm64")}\\2",
  "Linux arm64 sha256",
)
updated = replace_once(
  updated,
  %r{(exec-ecs_Linux_x86_64\.tar\.gz"\n\s+sha256 ")[a-f0-9]{64}(")},
  "\\1#{digests.fetch("linux_x86_64")}\\2",
  "Linux x86_64 sha256",
)

if updated == content
  puts "exec-ecs formula already at #{version}"
else
  FORMULA_PATH.write(updated)
  puts "updated exec-ecs formula to #{version}"
end
