class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.19.8.tgz"
  sha256 "c80dea24fc2f5e003a955d04c86cb0da8ad0b0cc0ffdd8e51f7ed725e89aa686"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["*"]

    (bin/"social").write <<~EOS
      #!/usr/bin/env bash
      exec "#{formula_opt_bin("node")}/node" "#{libexec}/bin/social.mjs" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Install the social agent skill with:
        npx skills add usesocial/skill
    EOS
  end

  test do
    assert_match(
      /social - Agentic founder-led distribution/,
      shell_output("#{bin}/social --help"),
    )
  end
end
