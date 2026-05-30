class Social < Formula
  desc "Connect agents to LinkedIn and X from the terminal"
  homepage "https://socialcli.dev"
  url "https://registry.npmjs.org/@usesocial/cli/-/cli-0.1.0.tgz"
  sha256 "0544b9042425d4e0b55d4080768df34e2ecfa5845ce626f0676ec17240619367"
  license :cannot_represent

  depends_on "bun"

  def install
    libexec.install Dir["*"]

    (bin/"social").write <<~EOS
      #!/bin/bash
      exec "#{Formula["bun"].opt_bin}/bun" "#{libexec}/dist/index.mjs" "$@"
    EOS
  end

  test do
    assert_match "connect X and LinkedIn", shell_output("#{bin}/social --help")
  end
end
