require 'weatherzone/connection'
require 'weatherzone/data_element'

module Weatherzone

  class DataElementNotAvailable < Exception
    attr_reader :message
    def initialize(resource_name, data_element_name)
      @message = "Data Element '#{data_element_name}' not available for '#{resource_name}'"
    end
  end

  INCLUDES_MAP = {
    :forecasts => "fc=1",
    :point_forecasts => "fc=3",
    :district_forecasts => "dist_fc=1",
    :conditions => "obs=1",
    :warnings => "warn=1",
    :state_forecasts => "state_fc=1",
    :uv_index => "uv=1",
    :sun => "fc_sun=2",
    :moon => "fc_moon=1",
    :historical_observations => "histobs=1"
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
      params   = options.delete(:params)
      params  += include_params(options.delete(:include)) if options[:include]
      params  += include_image(options.delete(:image))    if options[:image]
      params  += parse_params(options) unless options.empty?
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
        @fields[field] = DataElement.new(field, (element/field.to_sym)[0])
      end
      build_associations(element)
    end
    
    def hash
      @fields.collect { |field_name, data_element| data_element.hash }.hash
    end

    def eql?(other)
      self.hash == other.hash
    end
    
    
    def unavailable?
      @unavailable ||= @fields.all? { |field_name, data_element| data_element.unavailable? }
    end

    def available?
      !unavailable?
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
    
    def self.include_image(image)
      "&images=#{image[:type]}(days=#{image[:days]};size=#{image[:size]})"   
    end

    def self.parse_params(options)
      options.inject("") do |params, (key, value)|
        params += "&#{key}=#{value}"
      end      
    end

    def build_associations(element)
      build_has_many_associations(element)
      build_has_one_associations(element)
    end

    def build_has_many_associations(element)
      has_many_associations.each do |association, options|
        element_name = options[:element] || association.to_s.singularize.to_sym
        klass = class_name_from_options_or_implied(options, element_name) 
        ivar = "@#{association}".to_sym
        instance_variable_set(ivar, build_association(element, element_name, klass))
      end  
    end

    def build_has_one_associations(element)
      has_one_associations.each do |association, options|
        element_name = options[:element] || association
        klass = class_name_from_options_or_implied(options, element_name) 
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
      @fields[name.to_s] || @attributes[name.to_s] || raise(DataElementNotAvailable.new(self.class.name, name))
    end    
    
    def class_name_from_options_or_implied(options, element_name)
       options[:class_name] ? options[:class_name].constantize : element_name.to_s.classify.constantize 
    end
  end
end
