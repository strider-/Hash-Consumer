# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hash_consumer/version'

Gem::Specification.new do |gem|
  gem.name          = "hash_consumer"
  gem.version       = HashConsumer::VERSION
  gem.authors       = ["Michael Tighe"]
  gem.email         = ["striderIIDX@gmail.com"]
  gem.description   = %q{Consumes a Ruby hash and returns a object that has the hash keys as methods.}
  gem.summary       = %q{Consumes a Ruby hash and returns a object that has the hash keys as methods.
                      Example: test = {:name => "Mike"}.consume # test.name returns "Mike"}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
