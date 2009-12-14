require 'spec/rake/spectask'

root_dir = File.join(File.dirname(__FILE__), '..')

desc "Run all specs in spec directory (excluding plugin specs)"
Spec::Rake::SpecTask.new(:spec) do |t|
  t.spec_opts = ['--options', "\"#{root_dir}/spec/spec.opts\""]
  t.spec_files = FileList['spec/**/*_spec.rb']
end
