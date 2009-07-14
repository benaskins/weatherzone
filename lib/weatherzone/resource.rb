require 'weatherzone/connection'

module Weatherzone

  class Resource
    
    include SAXMachine

    class_inheritable_accessor :top_level_element, :temperature_unit, :temperature_attributes

    def self.inherited(klass)
      klass.class_eval do
        self.top_level_element ||= self.name.downcase
      end
    end

    def self.has_elements(*elements)
      elements.each do |e|
        element e
      end
    end

    def self.has_attribute(attr_name, options={})
      element_name = options[:on_elements] || self.top_level_element
      if element_name.is_a? Array
        element_name.each do |e|
          element e, :value => attr_name, :as => "#{e}_#{attr_name}"
        end
      else
        method_name = (element_name == self.top_level_element) ? "#{attr_name}" : "#{element_name}_#{attr_name}"
        element element_name, :value => attr_name, :as => method_name
      end
    end

    def settings
      Weatherzone::Settings.instance
    end
    # def hash
    #   @fields.collect { |field_name, data_element| data_element.hash }.hash
    # end
    # 
    # def eql?(other)
    #   self.hash == other.hash
    # end            
  end
end
