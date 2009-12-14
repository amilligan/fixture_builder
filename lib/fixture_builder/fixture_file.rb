require 'yaml'
require 'fileutils'
require 'active_support/test_case'

module FixtureBuilder
  class FixtureFile
    def initialize(table_name, data)
      @table_name = table_name
      @data = data
    end
    
    def write
      output_stream_for(@table_name) do |stream|
        stream.puts(@data.to_yaml)
      end
    end
    
    private
    
    def output_stream_for(table_name, &block)
      FileUtils.mkdir_p(ActiveSupport::TestCase.fixture_path)
      file_path = File.join(ActiveSupport::TestCase.fixture_path, "#{table_name}.yml")
      File.open(file_path, 'w', &block)
    end
  end
end
