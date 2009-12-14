module FixtureBuilder
  class Table
    attr_reader :name
    
    def initialize(name)
      @name = name
    end
    
    def clear
      klass.delete_all
    end
    
    def fixture_data(custom_names = {})
      reset_key_index
      klass.all.inject({}) do |data, record|
        data.merge(fixture_name_for(record, custom_names) => record.attributes.stringify_keys)
      end
    end
    
    private
    
    def klass
      @name.classify.constantize
    end
    
    def fixture_name_for(record, custom_names)
      custom_names[[klass, record.id]] || "#{@name}_#{next_key_index}"
    end
    
    def reset_key_index
      @key_index = 0
    end
    
    def next_key_index
      next_key_index = @key_index
      @key_index += 1
      next_key_index
    end
  end
end
