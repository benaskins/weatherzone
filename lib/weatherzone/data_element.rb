module Weatherzone  
  class DataElement
    attr_reader :value
  
    def initialize(xml_elem)
      @value      = xml_elem.inner_html
      @attributes = xml_elem.attributes
    end
  
    def inspect
      @value
    end
    
    def to_s
      @value
    end
  
    def [](key)
      @attributes[key.to_s]
    end
  end
end