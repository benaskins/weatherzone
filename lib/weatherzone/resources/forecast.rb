class Forecast < Weatherzone::Resource

  attributes :day

  has_elements :day_name, :date, :temp_min_c, :temp_max_c, :prob_precip, :icon,
    :rain_range_text, :frost_risk_text, :uv, :first_light, :sunrise, :sunset, :last_light,
    :moonrise, :moonset, :moon_phase

  has_attribute :units, :on_elements => [:temp_min_c, :temp_max_c, :prob_precip]
  has_attribute :index, :on_elements => :uv
  has_attribute :filename, :on_elements => :icon
  has_attribute :phase_num, :on_elements => :moon_phase
  has_attribute :phase_text, :on_elements => :moon_phase
  has_attribute :image_name, :on_elements => :moon_phase
  has_attribute :tz, :on_elements => [:first_light, :last_light, :sunset, :sunrise, :moonset, :moonrise]  
  
  elements :point_forecast, :as => :point_forecasts, :class => PointForecast  

  def icon_name
    icon_filename.split(".").first
  end

  def abbr_day_name
    self.day_name[0..2]
  end

  def date
    Date.parse(@date)
  end

  def chance_of_rain
    "#{self.prob_precip}#{self.prob_precip_units}"
  end

  def min_rain
    self.rain_range_text.split("-")[0].to_i if rain_range_text
  end

  def max_rain
    self.rain_range_text.split("-")[1].to_i if rain_range_text
  end

end