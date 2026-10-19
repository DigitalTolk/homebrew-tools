cask "ex" do
  version "0.0.22"
  sha256 "9af09a1ddf2bfff5cabbfe668d07ae54604f372f78e4b7ebf0720eb23ea1c97c"

  url "https://github.com/DigitalTolk/ex-electron/releases/download/v#{version}/ex-#{version}-mac-arm64.dmg"
  name "ex"
  desc "Desktop client for ex"
  homepage "https://github.com/DigitalTolk/ex-electron"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "ex.app"

  uninstall quit:       "com.digitaltolk.ex.electron",
            signal:     [["TERM", "com.digitaltolk.ex.electron"]],
            on_upgrade: :signal

  zap trash: [
    "~/Library/Application Support/ex",
    "~/Library/Caches/ex",
    "~/Library/Logs/ex",
    "~/Library/Preferences/com.digitaltolk.ex.electron.plist",
    "~/Library/Preferences/com.digitaltolk.ex.plist",
    "~/Library/Saved Application State/com.digitaltolk.ex.electron.savedState",
    "~/Library/Saved Application State/com.digitaltolk.ex.savedState",
  ]
end
