class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.11.10.tgz"
  sha256 "53f0efd3f3e708033cebea07fa78dc9eb487816cb7bdb5b563f993ade74672a7"
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
      /social - Let your agent run (LinkedIn & X for you|your LinkedIn)/,
      shell_output("#{bin}/social --help"),
    )
  end
end
