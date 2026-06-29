class CfdnsCli < Formula
  desc "Interactive browser for Cloudflare DNS zones and records"
  homepage "https://github.com/DigitalTolk/cfdns-cli"
  version "0.0.1"
  license "GPL-3.0-or-later"

  # version and the sha256 digests below are maintained automatically by
  # scripts/update-cfdns-cli-formula.rb from the latest GitHub release.

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Darwin_arm64.tar.gz"
      sha256 "31bc7ba56e67e20ef7e076da066b9b752acdab5ba851b7bbaa5abffac35e19d5"
    else
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Darwin_x86_64.tar.gz"
      sha256 "aeebeee616d56712bc387c4e206062a8adac0daacc38602401a7e838c7dd18e2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Linux_arm64.tar.gz"
      sha256 "79e8fdb2cf88d44180d95127a6b0a6b0ca37db515fe66f896d9798aa85224198"
    else
      url "https://github.com/DigitalTolk/cfdns-cli/releases/download/v#{version}/cfdns-cli_Linux_x86_64.tar.gz"
      sha256 "251f7b772ff7646bce6caece8de71832d31e2c6434ed697a46f5bc8e5fe8484f"
    end
  end

  def install
    bin.install "cfdns"
  end

  test do
    assert_match "cfdns version", shell_output("#{bin}/cfdns --version")
  end
end
