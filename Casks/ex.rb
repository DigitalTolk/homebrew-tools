cask "ex" do
  arch arm: "arm64"

  version "0.0.16"
  sha256 arm: "2ecdda73b611695aa3929f0c829cc69df337b89e4ef8b0928490d98fbc2a17ff"

  url "https://github.com/DigitalTolk/ex-electron/releases/download/v#{version}/ex-#{version}-mac-#{arch}.dmg"
  name "ex"
  desc "Desktop client for ex"
  homepage "https://github.com/DigitalTolk/ex-electron"

  depends_on arch: :arm64
  # Tracks the app's own LSMinimumSystemVersion, which comes from whichever
  # Electron major it bundles — Electron 44 (v0.0.16) raised it from Monterey
  # to Ventura. `brew audit --strict` fails the cask when the two disagree,
  # which blocks the automated update PR entirely, so this has to move with
  # the app rather than being left generous.
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
