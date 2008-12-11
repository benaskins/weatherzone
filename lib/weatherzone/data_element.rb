module Weatherzone
  
  class AttributeNotAvailable < Exception
    attr_reader :message
    def initialize(elem_name, attr_name)
      @message = "Attribute '#{attr_name}' not available for '#{elem_name}'"
    end
  end
  
  class DataElement
    attr_reader :value, :name
  
    def initialize(xml_elem)
      @name       = xml_elem.name
      @value      = xml_elem ? xml_elem.inner_html : nil
      @attributes = xml_elem ? xml_elem.attributes : nil
    end
  
    def inspect
      @value
    end
    
    def to_s
      @value
    end
  
    def at(name)
      @attributes[name.to_s] || raise(AttributeNotAvailable.new(self.name, name))
    end
  
    def [](key)
      at(key)
    end
    
    def method_missing(name)
      at(name)
    end
  end
end