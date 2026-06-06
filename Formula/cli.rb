class Cli < Formula
  desc "Agent-run distribution across X and LinkedIn"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.2.3.tgz"
  sha256 "e686ab7d7a4bcdabcd96f7f9a5249ea35411929b225fbce2d01f9d71903def31"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["*"]

    (bin/"social").write <<~EOS
      #!/usr/bin/env bash
      exec "#{Formula["node"].opt_bin}/node" "#{libexec}/bin/social.mjs" "$@"
    EOS
  end

  def caveats
    <<~EOS
      Install the social agent skill with:
        npx skills add usesocial/skill
    EOS
  end

  test do
    assert_match "social - Agent-run distribution", shell_output("#{bin}/social --help")
  end
end
