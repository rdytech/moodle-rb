lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'moodle/version'

Gem::Specification.new do |spec|
  spec.name          = 'moodle'
  spec.version       = Moodle::VERSION
  spec.authors       = ['Sam Giffney']
  spec.email         = ['samg@jobready.com.au']
  spec.summary       = %q{ Interaction with Moodle API }
  spec.homepage      = ''
  spec.license       = ''

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'ruby-debug', '0.10.4'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'webmock', '~> 1.0'
  spec.add_development_dependency 'vcr', '~> 2.9'

  spec.add_dependency 'httparty', '~> 0.11.0'
end
