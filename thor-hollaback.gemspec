# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thor/hollaback/version'

Gem::Specification.new do |spec|
  spec.name          = 'thor-hollaback'
  spec.version       = Thor::Hollaback::VERSION
  spec.authors       = ['Kevin Deisz']
  spec.email         = ['kevin.deisz@gmail.com']

  spec.summary       = 'Adds callbacks to thor commands'
  spec.homepage      = 'https://github.com/kddeisz/thor-hollaback'
  spec.license       = 'MIT'

  files              = `git ls-files -z`.split("\x0")
  spec.files         = files.reject { |f| f.match(%r{^test/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'hollaback', '~> 0.1.0'
  spec.add_dependency 'thor', '>= 0.19.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 0.73'
  spec.add_development_dependency 'simplecov', '~> 0.15'
end
