require 'fixture_builder/configuration'

class FixtureBuilder::Configuration
  # No ActiveRecord::Base.connection in these tests.
  attr_writer :available_tables
  def available_tables
    @available_tables ||= []
  end
end