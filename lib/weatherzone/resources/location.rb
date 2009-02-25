class Location < Weatherzone::Resource  
  attributes :type, :code, :name, :state

  has_elements :lat, :long, :elevation
  has_attribute :units, :on_elements => [:lat, :long, :elevation]
  
  elements :forecast, :as => :forecasts, :class => Forecast
  elements :conditions, :as => :conditions, :class => Conditions
  elements :district_forecast, :as => :district_forecasts, :class => DistrictForecast
  elements :state_forecast, :as => :state_forecasts, :class => StateForecast
  elements :historical_observation, :as => :historical_observations, :class => HistoricalObservation
  elements :daily_observations, :as => :daily_observations, :class => DailyObservation
  elements :warning, :as => :warnings, :class => Warning
  elements :image, :as => :images, :class => Image
  elements :almanac, :as => :almanacs, :class => Almanac

  # override base ruby Object#type
  attr_reader :type

  def id
    code
  end

  def current_forecast
    @current_forecast ||= forecasts.first
  end
  
  def current_district_forecast
    @current_district_forecast ||= district_forecasts.first
  end
  
  def current_district_forecast_precis
    current_district_forecast ? current_district_forecast.precis : "District forecast unavailable"  
  end
  
  def current_state_forecast
    @current_state_forecast ||= state_forecasts.first
  end
  
  def current_state_forecast_precis
    current_state_forecast ? current_state_forecast.precis : "State forecast unavailable"
  end
  
  def current_synoptic_chart
    @current_synoptic_chart ||= images.first
  end
  
  def current_synoptic_chart_text
    current_synoptic_chart ? current_synoptic_chart.text : "Synoptic chart unavailable"
  end
  
  def position
    "(#{self.lat}&deg;S, #{self.long}&deg;E, #{self.elevation}m AMSL)"
  end
  
  def url_slug
    self.name.parameterize
  end

end