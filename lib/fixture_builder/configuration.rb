require 'fixture_builder/table'

module FixtureBuilder
  class Configuration
    def define_fixtures
      tables.each(&:clear)
      yield
      write_fixture_files
    end

    attr_writer :skip_tables
    def skip_tables
      @skip_tables ||= %w{ schema_migrations }
    end

    private

    def available_tables
      raise NotImplementedError
    end

    def tables
      @tables ||= (available_tables - skip_tables).collect { |table_name| Table.new(table_name) }
    end

    def write_fixture_files
      tables.each { |table| FixtureFile.new(table.name, table.fixture_data).write }
    end
  end
end