class Cli < Formula
  desc "Agent-run distribution across X and LinkedIn"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.2.2.tgz"
  sha256 "a41597ca7ebeab164ba371b4c7caa76ac2a7e2933803bfceb834c7122d82cc99"
  license "MIT"

  depends_on "node"

  def install
    (bin/"social").write <<~EOS
      #!/usr/bin/env bash
      exec "#{Formula["node"].opt_bin}/npx" --yes --package "@usesocial/cli@0.2.2" social "$@"
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
