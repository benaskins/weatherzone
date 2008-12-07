require 'weatherzone/resources/forecast'
require 'weatherzone/resources/condition'

class Location < Weatherzone::Resource  

  has_many :forecasts
  has_one :conditions
  
  def self.find(location, params=nil)
    super(:location, params || "code=#{location}&fc=1&obs=1")
  end
  
  def self.find_by_name(location_name)
    super(:location, "lt=aploc&ln=#{location_name}&fc=1")
  end

  def self.capital_cities
    find(nil, "lt=twcid&lf=twccapcity&fc=1")
  end

  def id
    @attributes["code"]
  end

end