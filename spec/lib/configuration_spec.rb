require 'spec_helper'
require 'fixture_builder/configuration'

describe FixtureBuilder::Configuration do
  before(:each) do
    FixtureBuilder::FixtureFile.clear_files
    
    @configuration = FixtureBuilder::Configuration.new
    @configuration.available_tables = %w(universes galaxies)
  end
  
  describe "#define_fixtures" do
    context "with tables that contain row data" do
      before(:each) do
        Universe.data = [{:id => 1, :name => "Alternate"}, {:id => 2, :name => "Parallel"}, {:id => 3, :name => 'Normal'}]
        Galaxy.data = [{:id => 1, :name => "Milky Way", :universe_id => 3}]
      end
      
      it "should clear existing data" do
        @configuration.define_fixtures {}
        Universe.count.should == 0
      end
      
      it "should execute the specified block" do
        executed = false
        @configuration.define_fixtures { executed = true }
        executed.should be_true
      end
      
      it "should create a fixture file for each table" do
        @configuration.define_fixtures {}
        %w(universes galaxies).each { |table| FixtureBuilder::FixtureFile[table].should_not be_nil }
      end
      
      it "should write all models created in the specified block to the fixture file" do
        @configuration.define_fixtures do
          Galaxy.create!(:name => 'Andromeda')
          Galaxy.create!(:name => 'Triangulum')
        end
        
        output = FixtureBuilder::FixtureFile['galaxies'].written
        output.should match(/^  name: Andromeda/)
        output.should match(/^  name: Triangulum/)
      end
      
      context "with a table specified to be skipped" do
        before(:each) do
          @configuration.skip_tables << 'galaxies'
        end
        
        it "should not clear data from skipped tables" do
          galaxy_count = Galaxy.count
          galaxy_count.should_not == 0
          
          @configuration.define_fixtures {}
          Galaxy.count.should == galaxy_count
        end
        
        it "should not create a fixture file for skipped tables" do
          @configuration.define_fixtures {}
          FixtureBuilder::FixtureFile['galaxies'].should be_nil
        end
      end
    end
  end
end