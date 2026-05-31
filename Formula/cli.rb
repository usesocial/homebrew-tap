class Cli < Formula
  desc "Agent-run distribution across X and LinkedIn"
  homepage "https://usesocial.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.1.0.tgz"
  sha256 "0544b9042425d4e0b55d4080768df34e2ecfa5845ce626f0676ec17240619367"
  license "MIT"

  depends_on "node"

  def install
    (bin/"social").write <<~EOS
      #!/usr/bin/env bash
      exec "#{Formula["node"].opt_bin}/npx" --yes --package "@usesocial/cli@latest" social "$@"
    EOS
  end

  def caveats
    <<~EOS
      Install the social agent skill with:
        npx --yes skills add usesocial/skill -y -g all
    EOS
  end

  test do
    assert_match "Agent-run distribution", shell_output("#{bin}/social --help")
  end
end
