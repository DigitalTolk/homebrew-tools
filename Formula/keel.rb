class Keel < Formula
  desc "First-step server bootstrap and ops tool"
  homepage "https://github.com/DigitalTolk/keel"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Darwin_arm64.tar.gz"
      sha256 "bd7a69a1b6a2d56269289317683bda659c1e4dfe2ec7f64c87eacff2fb39001f"
    else
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Darwin_x86_64.tar.gz"
      sha256 "88be86f34b0eece1c2231d4a0b766a5a8314c378da883c21b362b63c379abbde"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Linux_arm64.tar.gz"
      sha256 "0e3fd3ede8654fc730d7938a312b16993c56b5d5e6cb2057f1150a6f91c7a564"
    else
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Linux_x86_64.tar.gz"
      sha256 "184d3ab7fb88377805b18a5cdae3fd8a25c5563bc615ad7e50ee17fc18e5a8d4"
    end
  end

  def install
    bin.install "keel"
  end

  test do
    assert_match "keel", shell_output("#{bin}/keel --version")
  end
end
