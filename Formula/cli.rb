class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.16.0.tgz"
  sha256 "fbb549139037c09caca60d872b73c79e4d1ed90d190af728ef476b3d78f90b59"
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
