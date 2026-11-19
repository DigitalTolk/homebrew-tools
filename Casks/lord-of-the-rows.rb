cask "lord-of-the-rows" do
  version "0.2.7"
  sha256 "6eb9a404d30f1609f5938ca7d3dd9bac0b85d27d1621dc19933c7244ef3b665d"

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
