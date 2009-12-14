require 'spec_helper'
require 'fixture_builder/fixture_file'

describe FixtureBuilder::FixtureFile do
  before(:each) do
    @data = { 
      'first_wibble' => { 'name' => 'Bethany', 'style' => 'fluffy' },
      'second_wibble' => { 'name' => 'Winston', 'style' => 'nappy' }
      }
    @fixture_file = FixtureBuilder::FixtureFile.new(@table_name, @data)
  end

  describe "#write" do
    it "should serialize the specified hash to the file" do
      @fixture_file.write
      @fixture_file.written.should == @data.to_yaml
    end
  end
end