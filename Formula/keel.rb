class Keel < Formula
  desc "First-step server bootstrap and ops tool"
  homepage "https://github.com/DigitalTolk/keel"
  version "0.1.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Darwin_arm64.tar.gz"
      sha256 "3630d16053024292fee0523c938aa4319ea11e6d5c320b9e1ff18101d31f6102"
    else
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Darwin_x86_64.tar.gz"
      sha256 "b0926f385e44cc447f4870f3c8a6743ab5e9b7d93b04363f0f35e8bd6891717c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Linux_arm64.tar.gz"
      sha256 "c8cd0d9158b59fdabc3051cbee8bfae24e5d33c4e7b8d9cd622d0d44db73d8e1"
    else
      url "https://github.com/DigitalTolk/keel/releases/download/v#{version}/keel_Linux_x86_64.tar.gz"
      sha256 "885eefea3e77856f722cb5d743e6e9ea82fd3f5ae6bd84cb13facc602dc80878"
    end
  end

  def install
    bin.install "keel"
  end

  test do
    assert_match "keel", shell_output("#{bin}/keel --version")
  end
end
