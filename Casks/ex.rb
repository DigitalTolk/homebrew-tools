cask "ex" do
  version "0.0.21"
  sha256 "f6be53685e73dc833276fb9abbe397f65e2e6352cf1e05bc9c709403c825f3a7"

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
