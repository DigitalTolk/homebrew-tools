class ExRunner < Formula
  desc "Runs ex agents (Claude Code, Codex) on this computer"
  homepage "https://github.com/DigitalTolk/ex-runners"
  version "0.0.2"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-darwin-arm64.tar.gz"
      sha256 "a6ae3a4639bc3e0d1dad12e8e8d0729f8f635797b0819c88769b94bc8c601fa9"
    else
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-darwin-amd64.tar.gz"
      sha256 "1807fb5be0c1fde28b18afbc901bdb15a26c035ac5a69a2937be1be7b9b17bd2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-linux-arm64.tar.gz"
      sha256 "e86b0e431b33872938d5cad91949937a0250852d4d3dedaf20f9ad983a7a9d64"
    else
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-linux-amd64.tar.gz"
      sha256 "351882238b2b71d0900d40b3f9547d1b173fb2ee25119a9699186d356b576ab3"
    end
  end

  def install
    bin.install "ex-runner"
  end

  def caveats
    <<~EOS
      Connect this computer to your ex account first:
        ex-runner login https://<your ex server>
      Then keep it running in the background, started at login:
        brew services start ex-runner
    EOS
  end

  service do
    run [opt_bin/"ex-runner", "start"]
    # Restart only after a crash: a runner that was disconnected on purpose
    # (removed on the Runners page, logged out) exits and must stay stopped.
    keep_alive crashed: true
    log_path var/"log/ex-runner.log"
    error_log_path var/"log/ex-runner.log"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ex-runner --version")
  end
end
