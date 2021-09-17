require './lib/brakeman/version'
require './gem_common'

Gem::Specification.new do |s|
  s.name = %q{brakeman}
  s.version = Brakeman::Version
  s.authors = ["Justin Collins"]
  s.email = "gem@brakeman.org"
  s.summary = "Security vulnerability scanner for Ruby on Rails."
  s.description = "Brakeman detects security vulnerabilities in Ruby on Rails applications via static analysis."
  s.homepage = "https://brakemanscanner.org"
  s.files = ["bin/brakeman", "CHANGES.md", "FEATURES", "README.md"] + Dir["lib/**/*"]
  s.executables = ["brakeman"]
  s.license = "Brakeman Public Use License"
  s.required_ruby_version = '>= 2.4.0'

  s.metadata = {
    "bug_tracker_uri"   => "https://github.com/presidentbeef/brakeman/issues",
    "changelog_uri"     => "https://github.com/presidentbeef/brakeman/releases",
    "documentation_uri" => "https://brakemanscanner.org/docs/",
    "homepage_uri"      => "https://brakemanscanner.org/",
    "mailing_list_uri"  => "https://gitter.im/presidentbeef/brakeman",
    "source_code_uri"   => "https://github.com/presidentbeef/brakeman",
    "wiki_uri"          => "https://github.com/presidentbeef/brakeman/wiki"
  }

  if File.exist? 'bundle/load.rb'
    # Pull in vendored dependencies
    s.files << 'bundle/load.rb'

    s.files += Dir['bundle/ruby/*/gems/**/*'].reject do |path|
      # Skip unnecessary files in dependencies
      path =~ /^bundle\/ruby\/\d\.\d\.\d\/gems\/[^\/]+\/(Rakefile|benchmark|bin|doc|example|man|site|spec|test)/
    end
  else
    Brakeman::GemDependencies.dev_dependencies(s) unless ENV['BM_PACKAGE']
    # Brakeman::GemDependencies.base_dependencies(s)
    s.add_dependency "parallel", "~>1.20"
    s.add_dependency "ruby_parser", "~>3.13"
    s.add_dependency "ruby_parser-legacy", "~>1.0"
    s.add_dependency "sexp_processor", "~> 4.7"
    s.add_dependency "ruby2ruby", "~>2.4.0"
    s.add_dependency "safe_yaml", ">= 1.0"
    # Brakeman::GemDependencies.extended_dependencies(s)
    s.add_dependency "terminal-table", "~>1.4"
    s.add_dependency "highline", "~>2.0"
    s.add_dependency "erubis", "~>2.6"
    s.add_dependency "haml", "~>5.1"
    s.add_dependency "slim", ">=1.3.6", "<=4.1"
    s.add_dependency "rexml", "~>3.0"
  end
end
