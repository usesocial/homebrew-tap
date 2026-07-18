class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.14.0.tgz"
  sha256 "2c46ac722f0f9eeaf201721e9fb95447587ca3cd0eccbc1b063f04312604af6b"
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
