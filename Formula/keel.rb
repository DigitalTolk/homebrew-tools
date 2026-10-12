class Keel < Formula
  desc "First-step server bootstrap and ops tool"
  homepage "https://github.com/DigitalTolk/keel"
  version "0.2.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Darwin_arm64.tar.gz"
      sha256 "88624991f02272229cd2bdaff3b422c98b66feaccd50f3c2c55d70559d779372"
    else
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Darwin_x86_64.tar.gz"
      sha256 "cc68bda292723fc57b1f04da322a85db03d3afdfe5bc81536876aa8678be9afd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Linux_arm64.tar.gz"
      sha256 "8a5297d231c2c81ae7c89a9f28b2568a55ffd8d5d4d65ad7ab3cfb05257c50c4"
    else
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Linux_x86_64.tar.gz"
      sha256 "cd3b0c9294073d3f87062303bbfdf8e8de0fb65de23834db437ec2dba7fbb415"
    end
  end

  def install
    bin.install "keel"
  end

  test do
    assert_match "keel", shell_output("#{bin}/keel --version")
  end
end
