cask "lord-of-the-rows" do
  version "0.2.2"
  sha256 "5b5bb1c34312f9666305b2fac3d114f4ea60c83a4b8b2e7605e0a98e21a08a6e"

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
