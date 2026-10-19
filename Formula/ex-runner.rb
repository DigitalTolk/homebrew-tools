class ExRunner < Formula
  desc "Runs ex agents (Claude Code, Codex) on this computer"
  homepage "https://github.com/DigitalTolk/ex-runners"
  version "0.0.3"
  license "GPL-3.0-only"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-darwin-arm64.tar.gz"
      sha256 "709b5028d5e09be4e3d15b880071900ffe9d82be080ded55d3f9fa10a6daa91d"
    else
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-darwin-amd64.tar.gz"
      sha256 "4b09866e07dce83652680621b77f3197717d63f83e1b1c87839f771c11777bd1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-linux-arm64.tar.gz"
      sha256 "61598179218ac867890a365943df4af24ad600f925504e513b7ca6e2fe858f4b"
    else
      url "https://github.com/DigitalTolk/ex-runners/releases/download/v#{version}/ex-runner-#{version}-linux-amd64.tar.gz"
      sha256 "484d040a2f6161eca9991e7159ac44edf3f1c0d23a3b8fc124e9a24aa16e50f5"
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
