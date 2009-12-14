require 'rake'
require 'rake/rdoctask'

load File.join(File.dirname(__FILE__), 'tasks', 'rspec.rake')

desc 'Default: run unit tests.'
task :default => :spec

desc 'Generate documentation for the fixture_builder plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'FixtureBuilder'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
