require 'weatherzone/connection'
require 'weatherzone/data_element'

module Weatherzone

  INCLUDES_MAP = {
    :forecasts => "fc=1",
    :district_forecasts => "dist_fc=1",
    :conditions => "obs=1"
  } 

  class Resource
    
    class_inheritable_accessor :fields, :has_many_associations, :has_one_associations

    self.fields = []
    self.has_many_associations = []
    self.has_one_associations = []

    @@connection = Weatherzone::Connection.instance

    def self.has_elements(*args)
      self.fields = args
    end

    def self.find(element_name, options)
      params = options[:params]
      params += include_params(options[:include]) if options[:include]
      
      response = @@connection.request(params)
      build_collection(element_name, response)
    rescue Weatherzone::RequestFailed => e
      @@connection.error(e.message)
    end
        
    def self.has_many(association, options={})
      define_method association do
        instance_variable_get("@#{association}".to_sym)
      end
      has_many_associations << [association, options] unless has_many_associations.include? association
    end

    def self.has_one(association, options={})
      define_method association do
        instance_variable_get("@#{association}".to_sym)
      end
      has_one_associations << [association, options] unless has_one_associations.include? association
    end

    def self.build_collection(element_name, response)
      (response/element_name).collect do |element|
        new(element)
      end
    end
  
    def initialize(element)
      @fields = {}
      @attributes = element.attributes
      self.class.fields.each do |field|
        @fields[field] = DataElement.new((element/field.to_sym)[0])
      end
      build_associations(element)
    end

    def [](key)
      @attributes[key.to_s]
    end

    protected
    def self.include_params(includes)
      includes.inject("") do |params, relationship|
        if param = INCLUDES_MAP[relationship]
          params += "&#{param}"
        else
          params
        end
      end
    end

    def build_associations(element)
      build_has_many_associations(element)
      build_has_one_associations(element)
    end

    def build_has_many_associations(element)
      has_many_associations.each do |association, options|
        element_name = options[:element] || association.to_s.singularize.to_sym
        klass = element_name.to_s.classify.constantize
        ivar = "@#{association}".to_sym
        instance_variable_set(ivar, build_association(element, element_name, klass))
      end  
    end

    def build_has_one_associations(element)
      has_one_associations.each do |association, options|
        element_name = options[:element] || association
        klass = element_name.to_s.classify.constantize
        ivar = "@#{association}".to_sym
        instance_variable_set(ivar, build_association(element, element_name, klass).first)
      end  
    end

    def build_association(element, element_name, klass)
      (element/element_name).collect do |xml_forecast|
        klass.new(xml_forecast)
      end
    end
      
    def method_missing(name)
      @fields[name.to_s]
    end    
        
  end
end
