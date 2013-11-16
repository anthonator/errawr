# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'errawr/version'

Gem::Specification.new do |spec|
  spec.name          = 'errawr'
  spec.version       = Errawr::VERSION
  spec.authors       = ['Anthony Smith']
  spec.email         = ['anthony@sticksnleaves.com']
  spec.description   = %q{Easily define and raise localized errors.}
  spec.summary       = %q{A framework for effectively defining and raising localized errors.}
  spec.homepage      = 'http://www.github.com/anthonator/errawr'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  
  spec.add_runtime_dependency 'i18n'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
