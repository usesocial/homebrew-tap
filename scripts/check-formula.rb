#!/usr/bin/env ruby

formula_path = ARGV.fetch(0) do
  abort "usage: ruby scripts/check-formula.rb Formula/cli.rb"
end

content = File.read(formula_path)
failures = []

def expect(failures, message)
  failures << message unless yield
end

semver_identifier = /(?:0|[1-9]\d*|\d*[A-Za-z-][0-9A-Za-z-]*)/
semver_pattern = /\A(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)\.(?:0|[1-9]\d*)(?:-#{semver_identifier}(?:\.#{semver_identifier})*)?(?:\+[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*)?\z/

url_match = content.match(%r{^\s*url "https://registry\.npmjs\.org/@usesocial/cli/-/cli-([^"]+)\.tgz"\s*$})
bin_names = content.scan(/\(bin\/"([^"]+)"\)\.write/).flatten

expect(failures, "formula class must be Cli") do
  content.match?(/^class Cli < Formula$/)
end

expect(failures, "url must be the @usesocial/cli npm tarball URL") do
  !url_match.nil?
end

if url_match
  version = url_match[1]

  expect(failures, "url version segment must be valid semver") do
    version.match?(semver_pattern)
  end
end

expect(failures, "sha256 must be exactly 64 lowercase hex characters") do
  content.match?(/^\s*sha256 "[0-9a-f]{64}"\s*$/)
end

expect(failures, "installed binary must be social") do
  bin_names == ["social"]
end

expect(failures, 'formula test must run #{bin}/social --help') do
  content.include?('shell_output("#{bin}/social --help")')
end

if failures.empty?
  puts "#{formula_path} looks good."
else
  failures.each { |failure| warn "error: #{failure}" }
  exit 1
end
