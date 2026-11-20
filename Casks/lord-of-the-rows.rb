cask "lord-of-the-rows" do
  version "0.2.9"
  sha256 "a259534ed495cbe580e193fa885cc4a12d63f01eb1aaff6cf67f9f932bef14cc"

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
