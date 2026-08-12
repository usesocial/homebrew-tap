class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.19.0.tgz"
  sha256 "e12bf390c8c74133e2817384a24b1c27839f0bdf2e3837253d95f9d9127607fb"
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
