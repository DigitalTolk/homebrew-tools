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

    system_command "/usr/bin/open",
                   args:         ["-b", "com.digitaltolk.ex.electron"],
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
