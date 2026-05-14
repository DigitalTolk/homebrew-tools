cask "ex" do
  arch arm: "arm64"

  version "0.0.5"
  sha256 arm: "b5ea235e4d3b5f1222d566c5035203deaa4f4172e023d5f7e23d6bb030f8fde4"

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
