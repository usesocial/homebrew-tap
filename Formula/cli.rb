class Cli < Formula
  desc "LinkedIn CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.11.9.tgz"
  sha256 "faf11ac4de53da57af54f79b8385913e3ee87ffd1e82322139e2a4371de2c821"
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
    assert_match "social - Let your agent run your LinkedIn", shell_output("#{bin}/social --help")
  end
end
