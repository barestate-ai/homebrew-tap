class Oms < Formula
  desc "Solana coding harness for your terminal"
  homepage "https://github.com/barestate-ai/oms"
  url "https://registry.npmjs.org/@barestate/oms/-/oms-0.1.2.tgz"
  sha256 "7933ebf64ca40cfcf570670546cc6d1376306129b50b9221e0a112701ad9c62c"
  license "MIT"

  depends_on "git"
  depends_on "node"
  depends_on "solana"

  def install
    system "npm", "install", *std_npm_args, "--ignore-scripts", "--no-audit", "--no-fund"
    native_platform = "#{OS.mac? ? "darwin" : "linux"}-#{Hardware::CPU.arm? ? "arm64" : "x64"}"
    libexec.glob("**/prebuilds/*").each do |prebuild|
      rm_r prebuild if prebuild.basename.to_s != native_platform
    end
    bin.install_symlink Dir[libexec/"bin/*"]
  end

  def caveats
    <<~EOS
      The first launch installs Surfpool and checks its SHA-256.
      To install it now, run:
        oms doctor --install
    EOS
  end

  test do
    assert_match "doctor", shell_output("#{bin}/oms --help")
  end
end
