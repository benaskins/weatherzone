class Forecast < Weatherzone::Resource
  has_elements "day_name", "date", "temp_min_c", "temp_max_c", "prob_precip", "icon",
    "rain_range_text", "frost_risk_text", "uv", "first_light", "sunrise", "sunset", "last_light",
    "moonrise", "moonset", "moon_phase"

  has_many :point_forecasts
  
  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&fc=1"
    super(:forecast, options)
  end

  def icon_name
    icon[:filename].split(".").first
  end

  def abbr_day_name
    self.day_name.to_s[0..2]
  end

  def chance_of_rain
    "#{self.prob_precip}#{self.prob_precip.units}"
  end

  def date
    Date.parse(@fields["date"].value)
  end

  def min_rain
    self.rain_range_text.split("-")[0].to_i
  end

  def max_rain
    self.rain_range_text.split("-")[1].to_i
  end

end