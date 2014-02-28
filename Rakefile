# encoding: utf-8
require 'rubygems'
require 'bundler/gem_tasks'

task default: [:spec, :rubocop]

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

require 'rubocop/rake_task'
Rubocop::RakeTask.new do |task|
  task.patterns = %w(lib/**/*.rb
                     spec/**/*.rb
                     Rakefile
                     Gemfile
                     shindan.gemspec)
end
