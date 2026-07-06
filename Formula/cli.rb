class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.12.3.tgz"
  sha256 "59ef6164025c4f9b206e654c5ae0240b82eda067e8b51a39b584266365037b1b"
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
