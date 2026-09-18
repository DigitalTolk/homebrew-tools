cask "ex" do
  arch arm: "arm64"

  version "0.0.15"
  sha256 arm: "b32a31f92df37f737acb651ff3ba2a046588bcf4069556634fea40cdd526047f"

  url "https://github.com/DigitalTolk/ex-electron/releases/download/v#{version}/ex-#{version}-mac-#{arch}.dmg"
  name "ex"
  desc "Desktop client for ex"
  homepage "https://github.com/DigitalTolk/ex-electron"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "ex.app"

  preflight_steps do
    terminate_process "ex"
  end

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
