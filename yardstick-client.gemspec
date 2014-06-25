# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yardstick-client/version'

Gem::Specification.new do |gem|
  gem.name          = "yardstick-client"
  gem.version       = Yardstick::Client::VERSION
  gem.authors       = ["Jason Wall", "Daniel Huckstep"]
  gem.email         = ["danielh@getyardstick.com"]
  gem.description   = %q{Gem for interacting with the Yardstick Admin API}
  gem.summary       = %q{Use this for your own integration with the Yardstick Measure platform. We use it too!}
  gem.homepage      = "http://www.github.com/yardstick/yardstick-client"
  gem.license       = 'MIT'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 1.9.2' # New hashes

  gem.add_dependency 'httparty', '~> 0.10.0'
  gem.add_dependency 'activesupport', '>= 3.2.13'
  gem.add_dependency 'activemodel', '>= 3.2.13'
  gem.add_dependency 'webmock', '~> 1.13.0'
  gem.add_dependency 'lol_concurrency', '~> 0.0.1'
  gem.add_dependency 'remote_associations', '~> 0.1.0'

  gem.add_development_dependency 'rspec', '~> 2.13.0'
  gem.add_development_dependency 'mocha', '~> 0.14.0'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency "pry", '~> 0.9'
  gem.add_development_dependency "pry-debugger", '~> 0.2'
end
