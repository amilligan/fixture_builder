require 'spec_helper'
require 'fixture_builder/table'

describe FixtureBuilder::Table do
  before(:each) do
    Galaxy.data = [{:id => 1, :name => 'Andromeda'}, {:id => 2, :name => 'Milky Way'}]
    @table = FixtureBuilder::Table.new('galaxies')
  end
  
  describe "#clear" do
    it "should remove all records from the specified table" do
      Galaxy.count.should_not == 0
      @table.clear
      Galaxy.count.should == 0
    end
  end
  
  describe "#fixture_data" do
    it "should return a hash of attributes for all rows in the table" do
      fixture_values = @table.fixture_data.values
      Galaxy.all.each do |galaxy|
        fixture_values.should include(galaxy.attributes.stringify_keys)
      end
    end
    
    context "without custom names for records" do
      it "should assign default unique keys to each row in the hash" do
        fixture_keys = @table.fixture_data.keys
        Galaxy.count.times do |i|
          fixture_keys.should include("galaxies_#{i}")
        end
      end
    end
    
    context "with custom names for records" do
      it "should assign the custom unique keys to rows in the hash" do        
        fixture_data = @table.fixture_data([Galaxy, 1] => 'andromeda', [Galaxy, 2] => 'lactose_intolerant')
        fixture_data['andromeda'].should == Galaxy.find(1).attributes.stringify_keys
        fixture_data['lactose_intolerant'].should == Galaxy.find(2).attributes.stringify_keys
      end
    end
  end
end