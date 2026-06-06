class Cli < Formula
  desc "Agent-run distribution across X and LinkedIn"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.2.1.tgz"
  sha256 "87e861f0ef2e2ca6d23f1590f413dd3006d8596bc2780afaa913096a99a6392c"
  license "MIT"

  depends_on "node"

  def install
    (bin/"social").write <<~EOS
      #!/usr/bin/env bash
      exec "#{Formula["node"].opt_bin}/npx" --yes --package "@usesocial/cli@0.2.1" social "$@"
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
