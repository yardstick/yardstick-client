# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yardstick-client/version'

Gem::Specification.new do |gem|
  gem.name          = "yardstick-client"
  gem.version       = Yardstick::Client::VERSION
  gem.authors       = ["Jason Wall", "Daniel Huckstep"]
  gem.email         = ["danielh@getyardstick.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "http://www.github.com/yardstick/yardstick-client"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency 'httparty', '~> 0.10.0'

  gem.add_development_dependency 'rspec', '~> 2.13.0'
end
