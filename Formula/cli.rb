class Cli < Formula
  desc "Agent-run distribution across X and LinkedIn"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.1.2.tgz"
  sha256 "6051d7d86e3bc950ad3c23113fa3eba59801d6a947a94e78ce2343791797b79c"
  license "MIT"

  depends_on "node"

  def install
    libexec.install Dir["package/*"]
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
