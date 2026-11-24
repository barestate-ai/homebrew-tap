class Oms < Formula
  desc "Solana coding harness for your terminal"
  homepage "https://github.com/barestate-ai/oms"
  url "https://registry.npmjs.org/@barestate/oms/-/oms-0.1.3.tgz"
  sha256 "12ce6eb8f6da5397c9cad48f6fbee5174c2cb65b6f177891ec681fd357daf115"
  license "MIT"

  depends_on "git"
  depends_on "node"
  depends_on "solana"

  def install
    system "npm", "install", *std_npm_args, "--ignore-scripts", "--no-audit", "--no-fund"
    os = OS.mac? ? "darwin" : "linux"
    arch = Hardware::CPU.arm? ? "arm64" : "x64"
    native_platform = "#{os}-#{arch}"
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
