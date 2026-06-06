class Cli < Formula
  desc "Agent-run distribution across X and LinkedIn"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.2.0.tgz"
  sha256 "71512420501424b33a91bf411c47744a50d8c55d8e2b6c3d95f9c0e66b866b74"
  license "MIT"

  depends_on "node"

  def install
    (bin/"social").write <<~EOS
      #!/usr/bin/env bash
      exec "#{Formula["node"].opt_bin}/npx" --yes --package "@usesocial/cli@0.2.0" social "$@"
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
