require 'weatherzone/resources/forecast'
require 'weatherzone/resources/district_forecast'
require 'weatherzone/resources/condition'
require 'weatherzone/resources/warning'

class Location < Weatherzone::Resource  

  has_elements "lat", "long", "elevation"

  has_many :forecasts
  has_many :district_forecasts
  has_one :conditions
  has_many :warnings
  
  def self.find(location, options={})
    options[:params] = options[:params] || "&code=#{location}"
    options[:params] += "&latlon=1"
    super(:location, options)
  end
  
  def self.find_by_name(location_name, options={})
    find(nil, options.merge(:params => "&lt=aploc&ln=#{location_name}"))
  end

  def self.filter(filter, options={})
    find(nil, options.merge(:params => "&lt=twcid&lf=#{filter}"))    
  end

  def self.capital_cities(options={})
    filter("twccapcity", options.merge(:params => "&lt=twcid"))
  end

  def id
    @attributes["code"]
  end

end