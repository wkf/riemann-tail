# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'riemann/tail/version'

Gem::Specification.new do |spec|
  spec.name          = "riemann-tail"
  spec.version       = Riemann::Tail::VERSION
  spec.authors       = ["Will Farrell"]
  spec.email         = ["will@mojotech.com"]
  spec.summary       = %q{Subscribe (tail) Riemann event streams from the console}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/wkf/riemann-tail"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor', '~> 0'
  spec.add_runtime_dependency 'colorize', '~> 0'
  spec.add_runtime_dependency 'faye-websocket', '~> 0'

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
end
