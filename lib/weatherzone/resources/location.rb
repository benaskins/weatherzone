class Location < Weatherzone::Resource  
  attributes :type, :code, :name, :state

  has_elements :lat, :long, :elevation
  has_attribute :units, :on_elements => [:lat, :long, :elevation]

  elements :forecast, :as => :forecasts, :class => Forecast
  elements :conditions, :as => :conditions, :class => Conditions
  elements :district_forecast, :as => :district_forecasts, :class => DistrictForecast
  elements :state_forecast, :as => :state_forecasts, :class => StateForecast
  elements :marine_forecast, :as => :marine_forecasts, :class => MarineForecast
  elements :surf_report, :as => :surf_reports, :class => SurfReport
  elements :snow_report, :as => :snow_reports, :class => SnowReport
  elements :historical_observation, :as => :historical_observations, :class => HistoricalObservation
  elements :daily_observations, :as => :daily_observations, :class => DailyObservation
  elements :climate_period, :as => :climate_periods, :class => ClimatePeriod
  elements :warning, :as => :warnings, :class => Warning
  elements :almanac, :as => :almanacs, :class => Almanac
  elements :tide, :as => :tides, :class => Tide
  
  elements :image, :as => :synoptic_charts, :with => {:type => "Synoptic chart"}, :class => Image

  element :link, :value => :url, :as => :radar_animator, :with => {:type => "radar animator"}
  element :link, :value => :url, :as => :radar_still, :with => {:type => "radar still"}
  element :link, :value => :width, :as => :radar_still_width, :with => {:type => "radar still"}
  element :link, :value => :height, :as => :radar_still_height, :with => {:type => "radar still"}

  element :link, :value => :url, :as => :satellite_animator, :with => {:type => "satellite animator"}
  element :link, :value => :url, :as => :satellite_still, :with => {:type => "satellite still"}

  # override base ruby Object#type
  attr_reader :type

  def id
    code
  end

  def current_forecast
    @current_forecast ||= forecasts.first
  end

  def current_conditions
    @current_conditions ||= conditions.first
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
    synoptic_chart.first
  end
  
  def current_synoptic_chart_text
    current_synoptic_chart ? current_synoptic_chart.text : "Synoptic chart unavailable"
  end
  
  def current_marine_forecast
    @marine_forecast ||= marine_forecasts.first
  end
  
  def historical_observations_shifted_to_nearest_half_hour
    obs_to_shift = historical_observations.uniq.reverse
    historical_observations.each do |ho|
      break if ho.is_on_the_half_hour?
      obs_to_shift.shift
    end
    obs_to_shift
  end
  
  def hourly_observations
    historical_observations.uniq.reverse.select { |ho| ho.is_on_the_hour? }    
  end
  
  def position
    "(#{self.lat}&deg;S, #{self.long}&deg;E, #{self.elevation}m AMSL)"
  end
  
  def url_slug
    self.name.parameterize
  end

  def <=>(other)
    self.name <=> other.name
  end

end