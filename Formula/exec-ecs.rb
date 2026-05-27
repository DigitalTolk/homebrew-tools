class ExecEcs < Formula
  desc "Interactive ECS execute-command helper"
  homepage "https://github.com/DigitalTolk/exec-ecs"
  version "1.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Darwin_arm64.tar.gz"
      sha256 "db74c63a427949c5b993d0b818418e2e36e89eff4bb7e2bec7d007039d6cc903"
    else
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Darwin_x86_64.tar.gz"
      sha256 "96f6136f39d2b01b74b42fcb196c67456ab9b2308324f34e3f7433abf431be52"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Linux_arm64.tar.gz"
      sha256 "145d06bfb833f9911335faf13ba8d8acf2dd42d1ce71791f6752e6903a1b28d4"
    else
      url "https://github.com/DigitalTolk/exec-ecs/releases/download/v#{version}/exec-ecs_Linux_x86_64.tar.gz"
      sha256 "8c4fca3075f6b8d03553738bae679da382988ffe6e5f39ea8cee1bb1cb3cf85d"
    end
  end

  def install
    bin.install "exec-ecs"
  end

  test do
    assert_match "exec-ecs version", shell_output("#{bin}/exec-ecs --version")
  end
end
