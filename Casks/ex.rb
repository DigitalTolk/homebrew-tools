cask "ex" do
  version "0.0.23"
  sha256 "3f846544ca4d9b1fa6d44e369854fe54e850c862f845c2983434ec21692ae3d5"

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
