require 'rubygems'
require 'spec'

require 'active_hash'
require 'active_record/fixtures'

spec_helpers_dir = File.join(File.dirname(__FILE__), 'spec_helpers')
$LOAD_PATH.unshift spec_helpers_dir
Dir.glob("#{spec_helpers_dir}/**/*.rb").each do |file|
  require file
end

Spec::Runner.configure do |configuration|
  configuration.before(:each) do
    Dir.stub(:mkdir)
    File.stub(:open)
  end
end

class ActiveSupport::TestCase
  include ActiveRecord::TestFixtures
  self.fixture_path = "/path/to/fixtures/"
end