class Cli < Formula
  desc "LinkedIn & X CLI"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.11.1.tgz"
  sha256 "a4190b16760a84f3bc5ddb127f9e1e7feb6c2af1fc05a9601f38a2e78fc91faa"
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
