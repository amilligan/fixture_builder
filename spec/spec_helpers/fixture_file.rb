require 'fixture_builder/fixture_file'

class FixtureBuilder::FixtureFile
  class << self
    def new_with_file_recording(table_name, *args)
      files[table_name] = new_without_file_recording(table_name, *args)
    end
    alias_method_chain :new, :file_recording
  end
  
  def self.[](table_name)
    files[table_name]
  end
  
  def self.clear_files
    @files = {}
  end
  
  def written
    @output_stream.rewind
    @output_stream.read
  end
  
  private
  
  def self.files
    @files ||= {}
  end

  def output_stream_for(table_name, &block)
    @output_stream = StringIO.new
    block.call(@output_stream)
  end
end