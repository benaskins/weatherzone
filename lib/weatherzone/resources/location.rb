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
    location_name = location_name.gsub(" ", "%20").gsub("-", "%20")
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
    current_district_forecast.available? ? current_district_forecast.precis : "District forecast unavailable"  
  end

  def current_state_forecast
    @current_state_forecast ||= state_forecasts.first
  end
  
  def current_state_forecast_precis
    current_state_forecast.available? ? current_state_forecast.precis : "State forecast unavailable"
  end

  def current_synoptic_chart
    @current_synoptic_chart ||= images.first
  end

  def current_synoptic_chart_text
    current_synoptic_chart.available? ? current_synoptic_chart.text : "Synoptic chart unavailable"
  end
  
  def position
    "(#{self.lat}&deg;S, #{self.long}&deg;E, #{self.elevation}m AMSL)"
  end

  def url_slug
    self.name.parameterize
  end

  def id
    @attributes["code"]
  end

end