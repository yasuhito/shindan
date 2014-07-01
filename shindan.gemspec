# -*- coding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shindan'

Gem::Specification.new do | gem |
  gem.name = 'shindan'
  gem.version = Shindan::VERSION
  gem.summary = 'Shindan maker for Ruby'
  gem.description = 'Shindan maker (http://shindanmaker.com/) wrapper library.'

  gem.license = 'GPL3'

  gem.authors = ['Yasuhito Takamiya']
  gem.email = ['yasuhito@gmail.com']
  gem.homepage = 'http://github.com/yasuhito/shindan'

  gem.files = `git ls-files`.split("\n")

  gem.require_paths = ['lib']

  gem.extra_rdoc_files = ['README.md']
  gem.test_files = `git ls-files -- {spec,features}/*`.split("\n")

  gem.add_dependency 'mechanize', '~> 2.7.3'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec', '~> 3.0.0'
  gem.add_development_dependency 'rubocop', '~> 0.24.0'
end

### Local variables:
### mode: Ruby
### coding: utf-8-unix
### indent-tabs-mode: nil
### End:
