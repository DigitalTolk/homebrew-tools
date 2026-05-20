cask "ex" do
  arch arm: "arm64"

  version "0.0.6"
  sha256 arm: "90d46debca4d257e6f5868e46be64ec23a565fc2830c6bfb2b70c30e197db7cd"

  url "https://github.com/DigitalTolk/ex-electron/releases/download/v#{version}/ex-#{version}-mac-#{arch}.dmg"
  name "ex"
  desc "Desktop client for ex"
  homepage "https://github.com/DigitalTolk/ex-electron"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "ex.app"

  zap trash: [
    "~/Library/Application Support/ex",
    "~/Library/Caches/ex",
    "~/Library/Logs/ex",
    "~/Library/Preferences/com.digitaltolk.ex.plist",
    "~/Library/Saved Application State/com.digitaltolk.ex.savedState",
  ]
end
