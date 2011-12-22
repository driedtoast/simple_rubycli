$:.unshift File.expand_path("../lib", __FILE__)

Gem::Specification.new do |gem|
  gem.name    = "simplecli"
  gem.version = "1"

  gem.author      = "driedtoast"
  gem.email       = "dan@driedtoast.com"
  gem.homepage    = "http://www.driedtoast.com/"
  gem.summary     = "Simple CLI Using ruby."
  gem.description = "Simple CLI for playing around"
  gem.executables = "enc"

  gem.files = %x{ git ls-files }.split("\n").select { |d| d =~ %r{^(README|bin/|data/|ext/|lib/|spec/|test/)} }

  gem.add_dependency "term-ansicolor", "~> 1.0.5"
  gem.add_dependency "rest-client",    "~> 1.6.1"
  gem.add_dependency "launchy",        ">= 0.3.2"
  gem.add_dependency "rubyzip"
end
