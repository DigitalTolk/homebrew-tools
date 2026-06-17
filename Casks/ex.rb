cask "ex" do
  arch arm: "arm64"

  version "0.0.10"
  sha256 arm: "53404eeebf1c23e1a28f7f5d4808ea2ab9599f8535bf7655c2f1a057a8287240"

  url "https://github.com/DigitalTolk/ex-electron/releases/download/v#{version}/ex-#{version}-mac-#{arch}.dmg"
  name "ex"
  desc "Desktop client for ex"
  homepage "https://github.com/DigitalTolk/ex-electron"

  depends_on arch: :arm64
  depends_on macos: :monterey

  app "ex.app"

  preflight do
    was_running = quiet_system "/usr/bin/pgrep", "-x", "ex"
    marker = "/tmp/homebrew-ex-was-running-#{Process.uid}"

    if was_running
      File.write(marker, "1")
    else
      FileUtils.rm(marker, force: true)
    end

    system_command "/usr/bin/osascript",
                   args:         [
                     "-e",
                     'tell application id "com.digitaltolk.ex.electron" to quit',
                   ],
                   must_succeed: false

    10.times do
      break unless quiet_system "/usr/bin/pgrep", "-x", "ex"

      sleep 1
    end

    system_command "/usr/bin/pkill",
                   args:         ["-x", "ex"],
                   must_succeed: false
  end

  postflight do
    marker = "/tmp/homebrew-ex-was-running-#{Process.uid}"
    was_running = File.exist?(marker)

    FileUtils.rm(marker, force: true)
    next unless was_running

    # Relaunch by explicit path, not bundle id. A stray copy of ex.app (e.g. a
    # local dev build under release/) registers the same CFBundleIdentifier, and
    # `open -b com.digitaltolk.ex.electron` lets LaunchServices pick whichever it
    # prefers — which can be the older shadow copy. Pointing at the just-installed
    # bundle keeps the relaunch unambiguous.
    system_command "/usr/bin/open",
                   args:         ["#{appdir}/ex.app"],
                   must_succeed: false
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
