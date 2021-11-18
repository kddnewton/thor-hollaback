# frozen_string_literal: true

require_relative 'lib/thor/hollaback/version'

version = Thor::Hollaback::VERSION
repository = 'https://github.com/kddnewton/thor-hollaback'

Gem::Specification.new do |spec|
  spec.name          = 'thor-hollaback'
  spec.version       = version
  spec.authors       = ['Kevin Newton']
  spec.email         = ['kddnewton@gmail.com']

  spec.summary       = 'Adds callbacks to thor commands'
  spec.homepage      = repository
  spec.license       = 'MIT'

  spec.metadata = {
    'bug_tracker_uri' => "#{repository}/issues",
    'changelog_uri' => "#{repository}/blob/v#{version}/CHANGELOG.md",
    'source_code_uri' => repository,
    'rubygems_mfa_required' => 'true'
  }

  files              = `git ls-files -z`.split("\x0")
  spec.files         = files.reject { |f| f.match(%r{^test/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'hollaback', '~> 0.1'
  spec.add_dependency 'thor', '>= 0.19.1'

  spec.add_development_dependency 'bundler', '~> 2.0'
  spec.add_development_dependency 'minitest', '~> 5.11'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rubocop', '~> 1.12'
  spec.add_development_dependency 'simplecov', '~> 0.15'
end
