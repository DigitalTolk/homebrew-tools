class CfdnsCli < Formula
  desc "Interactive browser for Cloudflare DNS zones and records"
  homepage "https://github.com/DigitalTolk/cfdns-cli"
  version "0.1.0"
  license "GPL-3.0-or-later"

  # version and the sha256 digests below are maintained automatically by
  # scripts/update-cfdns-cli-formula.rb from the latest GitHub release.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Darwin_arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Darwin_x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Linux_arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Linux_x86_64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "cfdns"
  end

  test do
    assert_match "cfdns version", shell_output("#{bin}/cfdns --version")
  end
end
