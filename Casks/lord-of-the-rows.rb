cask "lord-of-the-rows" do
  version "0.2.5"
  sha256 "4cfebd2f7c7ff41aef767a6f9043f3dbfe783c08d5ab0db09be01e79ec391a10"

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
