#!/usr/bin/env ruby
# frozen_string_literal: true

require "digest"
require "json"
require "net/http"
require "open3"
require "pathname"
require "tmpdir"
require "uri"

ROOT = Pathname.new(__dir__).parent
CASK_PATH = ROOT/"Casks/ex.rb"
RELEASE_URL = URI("https://api.github.com/repos/DigitalTolk/ex-electron/releases/latest")
ASSET_PATTERN = /\Aex-(?<version>\d+\.\d+\.\d+)-mac-arm64\.dmg\z/
DEPENDS_ON_MACOS_PATTERN = /depends_on macos: :\w+/
MACOS_SYMBOLS = {
  "26" => "tahoe",
  "15" => "sequoia",
  "14" => "sonoma",
  "13" => "ventura",
  "12" => "monterey",
  "11" => "big_sur",
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

def run!(*command)
  output, status = Open3.capture2e(*command)
  abort "#{command.first} failed:\n#{output}" unless status.success?

  output
end

# `brew audit --strict` requires `depends_on macos:` to match the app bundle's
# LSMinimumSystemVersion, which moves whenever ex-electron bumps Electron.
def minimum_macos(url, sha256)
  Dir.mktmpdir do |dir|
    dmg = File.join(dir, "ex.dmg")
    mountpoint = File.join(dir, "mount")
    Dir.mkdir(mountpoint)

    run!("curl", "--fail", "--silent", "--show-error", "--location", "--output", dmg, url)
    abort "#{url} does not match its release digest" unless Digest::SHA256.file(dmg).hexdigest == sha256

    run!("hdiutil", "attach", "-nobrowse", "-readonly", "-noautoopen", "-mountpoint", mountpoint, dmg)
    begin
      version = run!("plutil", "-extract", "LSMinimumSystemVersion", "raw",
                     File.join(mountpoint, "ex.app/Contents/Info.plist")).strip
    ensure
      run!("hdiutil", "detach", "-quiet", mountpoint)
    end

    MACOS_SYMBOLS.fetch(version[/\A\d+/]) do
      abort "Unknown LSMinimumSystemVersion #{version}; add it to MACOS_SYMBOLS"
    end
  end
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
  exit
end

abort "Could not find depends_on macos; cask layout changed" unless updated.match?(DEPENDS_ON_MACOS_PATTERN)

macos = minimum_macos(asset.fetch("browser_download_url"), sha256)
CASK_PATH.write(updated.sub(DEPENDS_ON_MACOS_PATTERN, "depends_on macos: :#{macos}"))
puts "updated ex cask to #{tag_version} (depends_on macos: :#{macos})"
