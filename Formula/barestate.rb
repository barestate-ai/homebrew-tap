class Barestate < Formula
  desc "On-device computer use for macOS"
  homepage "https://barestate.xyz"
  head "https://github.com/barestate-ai/barestate-mac-app.git", branch: "main"

  depends_on arch: :arm64
  depends_on macos: :tahoe

  def install
    system "scripts/build-app.sh", "release", "--disable-sandbox"
    prefix.install "build/Barestate.app"
  end

  def caveats
    <<~EOS
      Link the app into Applications:
        ln -sfn #{opt_prefix}/Barestate.app /Applications/Barestate.app

      Each upgrade is a new build, so macOS asks for Screen Recording and
      Accessibility again.
    EOS
  end

  test do
    system "codesign", "--verify", "--deep", "--strict", prefix/"Barestate.app"
  end
end
