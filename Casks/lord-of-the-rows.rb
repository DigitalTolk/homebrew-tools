cask "lord-of-the-rows" do
  version "0.2.13"
  sha256 "fe70a5c43612a69f71d95a3f4a69d778bb703915eb3f56c3630c034ca553f56e"

  url "https://github.com/DigitalTolk/Lord-of-the-Rows/releases/download/v#{version}/LordOfTheRows-#{version}-universal.dmg"
  name "Lord of the Rows"
  desc "Desktop database client"
  homepage "https://github.com/DigitalTolk/Lord-of-the-Rows"

  depends_on :macos

  app "Lord of the Rows.app"

  uninstall quit: "dev.lordoftherows.app"

  # Saved passwords are kept in the macOS Keychain and are not removed here.
  zap trash: [
    "~/Library/Application Support/dev.lordoftherows.app",
    "~/Library/Caches/dev.lordoftherows.app",
    "~/Library/Preferences/dev.lordoftherows.app.plist",
    "~/Library/Saved Application State/dev.lordoftherows.app.savedState",
    "~/Library/WebKit/dev.lordoftherows.app",
  ]
end
