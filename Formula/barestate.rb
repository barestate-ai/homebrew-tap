class Barestate < Formula
  desc "On-device computer use for macOS"
  homepage "https://barestate.xyz"
  head "https://github.com/barestate-ai/barestate-mac-app.git", branch: "main"

  depends_on arch: :arm64
  depends_on macos: :sonoma

  def install
    system "scripts/build-app.sh", "release", "--disable-sandbox"
    prefix.install "build/Orb.app"
  end

  def caveats
    <<~EOS
      Link the app into Applications:
        ln -sfn #{opt_prefix}/Orb.app /Applications/Orb.app

      Each upgrade is a new build, so macOS asks for Screen Recording and
      Accessibility again.
    EOS
  end

  test do
    system "codesign", "--verify", "--deep", "--strict", prefix/"Orb.app"
  end
end
