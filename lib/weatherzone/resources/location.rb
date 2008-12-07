require 'weatherzone/resources/forecast'
require 'weatherzone/resources/district_forecast'
require 'weatherzone/resources/condition'

class Location < Weatherzone::Resource  

  has_many :forecasts
  has_many :district_forecasts
  has_one :conditions
  
  def self.find(location, options={})
    options[:params] = options[:params] || "&code=#{location}"
    super(:location, options)
  end
  
  def self.find_by_name(location_name, options={})
    find(:location, options.merge(:params => "&lt=aploc&ln=#{location_name}"))
  end

  def self.capital_cities(options={})
    find(nil, options.merge(:params => "&lt=twcid&lf=twccapcity"))
  end

  def id
    @attributes["code"]
  end

end