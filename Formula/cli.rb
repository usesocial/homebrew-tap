class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.11.8.tgz"
  sha256 "3ce1b299d7d0fc43641ac30e2aa7478f97a581f91196f45a8175197ae6529165"
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
    assert_match "social - Let your agent run LinkedIn & X for you", shell_output("#{bin}/social --help")
  end
end
