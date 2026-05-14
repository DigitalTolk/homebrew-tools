#!/usr/bin/env ruby
# frozen_string_literal: true

require "json"
require "net/http"
require "pathname"
require "uri"

ROOT = Pathname.new(__dir__).parent
CASK_PATH = ROOT/"Casks/ex.rb"
RELEASE_URL = URI("https://api.github.com/repos/DigitalTolk/ex-electron/releases/latest")
ASSET_PATTERN = /\Aex-(?<version>\d+\.\d+\.\d+)-mac-arm64\.dmg\z/

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
tag_version = release.fetch("tag_name").delete_prefix("v")
asset = release.fetch("assets").find { |item| ASSET_PATTERN.match?(item.fetch("name")) }

abort "No macOS ARM DMG found on release #{release.fetch("tag_name")}" unless asset

asset_version = ASSET_PATTERN.match(asset.fetch("name"))[:version]
abort "Release tag #{tag_version} does not match asset version #{asset_version}" unless tag_version == asset_version

digest = asset["digest"].to_s
abort "Release asset #{asset.fetch("name")} has no sha256 digest" unless digest.start_with?("sha256:")

sha256 = digest.delete_prefix("sha256:")
content = CASK_PATH.read
updated = content
          .sub(/version "[^"]+"/, %(version "#{tag_version}"))
          .sub(/sha256 arm: "[a-f0-9]{64}"/, %(sha256 arm: "#{sha256}"))

if updated == content
  puts "ex cask already at #{tag_version}"
else
  CASK_PATH.write(updated)
  puts "updated ex cask to #{tag_version}"
end
