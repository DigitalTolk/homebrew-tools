class ExRunner < Formula
  desc "Runs ex agents (Claude Code, Codex) on this computer"
  homepage "https://github.com/DigitalTolk/ex-runners"
  version "0.0.1"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-darwin-arm64.tar.gz"
      sha256 "446c772e894fb5cbe7c80f68730e6d3d8f415a9122c23f31a723b203e82cc916"
    else
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-darwin-amd64.tar.gz"
      sha256 "68dcce02c9c3a96b3f1cba2b5fb0a6579fe776168ab87fbb0d2ae54c94df506b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-linux-arm64.tar.gz"
      sha256 "b34cef6bb9db89dac62f9262bf9e7a2ff276e3e9aae0fa1997dee990b50faeed"
    else
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-linux-amd64.tar.gz"
      sha256 "f3fb33c1feb1dcd44d13f9785166feb89f52726b7b2308cc1d45c494d6946450"
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
