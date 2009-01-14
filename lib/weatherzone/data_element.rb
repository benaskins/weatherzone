module Weatherzone
  
  class AttributeNotAvailable < Exception
    attr_reader :message
    def initialize(elem_name, attr_name)
      @message = "Attribute '#{attr_name}' not available for '#{elem_name}'"
    end
  end
  
  class DataElement
    attr_reader :value, :name
  
    def initialize(name, xml_elem)
      @name       = name
      @value      = (!xml_elem || xml_elem.inner_html.blank?) ? "n/a" : xml_elem.inner_html
      @attributes = xml_elem ? xml_elem.attributes : {}
    end
    
    def hash
      (@name + @value).hash
    end

    def eql?(other)
      self.is_a?(other.class) && self.name.eql?(other.name) && self.value.eql?(other.value)
    end

    def ==(other)
      self.to_s == other.to_s
    end
    
    def unavailable?
      @value == "n/a"
    end
    
    def available?
      !unavailable?
    end
  
    def inspect
      @value
    end
    
    def to_s
      @value
    end
  
    def to_param
      @value.downcase
    end
  
    def at(name)
      @attributes[name.to_s] || "n/a"
    end
  
    def [](key)
      at(key)
    end
    
    def method_missing(name, *args)
      # Try delegating to to_s, otherwise look for an attribute
      if to_s.respond_to?(name)
        to_s.send(name, *args)
      else
        at(name)
      end
    end
    
  end
end