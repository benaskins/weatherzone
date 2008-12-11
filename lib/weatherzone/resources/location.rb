class Location < Weatherzone::Resource  

  has_elements "lat", "long", "elevation"

  has_many :forecasts
  has_many :district_forecasts
  has_many :state_forecasts
  has_one :conditions
  has_many :warnings
  has_many :images
  
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

  def current_district_forecast
    @current_district_forecast ||= district_forecasts.first
  end
  
  def current_district_forecast_precis
    current_district_forecast ? current_district_forecast.precis : "District forecast not available"
  end

  def current_state_forecast
    @current_state_forecast ||= state_forecasts.first
  end
  
  def current_state_forecast_precis
    current_state_forecast ? current_state_forecast.precis : "State forecast not available"
  end


end