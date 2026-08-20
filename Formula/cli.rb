class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.19.5.tgz"
  sha256 "e5633354aa86e389d46b90629ebc85739c2f9375729b5ff33fa79962e0a007c7"
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
