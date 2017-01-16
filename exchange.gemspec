# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'exchange/version'

Gem::Specification.new do |spec|
  spec.name          = "exchange"
  spec.version       = Exchange::VERSION
  spec.authors       = ["Martin Eismann"]
  spec.email         = ["softwerk@eismann.cc"]

  spec.summary       = %q{Performs currency conversions at specified rates as well as simple arithmetic operations}
  spec.description   = %q{Performs currency conversions at specified rates as well as simple arithmetic operations}
  spec.homepage      = "https://github.com/meismann/exchange"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry"
end
