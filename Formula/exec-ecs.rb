class ExecEcs < Formula
  desc "Interactive ECS execute-command helper"
  homepage "https://github.com/DigitalTolk/exec-ecs"
  version "1.1.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Darwin_arm64.tar.gz"
      sha256 "82ec4966780ee11f8fb2a53102fbe493f9ef04fbb1be870e9e886b7bc2e0b165"
    else
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Darwin_x86_64.tar.gz"
      sha256 "ac54757ddfe321dda4ef3a8b2cfb17cb66dbc36e71fd21e40cdfb0955dd090f4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Linux_arm64.tar.gz"
      sha256 "fe48d260ab3a9874596266adfe06ae37f99fc055fc1588af7ff703fafa9b619d"
    else
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Linux_x86_64.tar.gz"
      sha256 "3a398f532912035a0e1b7cef2045babf283356b7faabebc80738ca3744168978"
    end
  end

  def install
    bin.install "exec-ecs"
  end

  test do
    assert_match "exec-ecs version", shell_output("#{bin}/exec-ecs --version")
  end
end
