class PointForecast < Weatherzone::Resource
  attributes :time
  has_elements :dp_c, :rh, :wind_dir_degrees, :wind_dir_compass, :wind_speed_kph
  has_attribute :units, :on_elements => [:dp_c, :rh, :wind_dir_degrees, :wind_speed_kph]

  WIND_DIRECTIONS = {
    :N => "North",
    :NNE => "North North East",
    :NE => "North East",
    :ENE => "East North East",
    :E => "East",
    :ESE => "East South East",
    :SE => "South East",
    :SSE => "South South East",
    :S => "South",
    :SSW => "South South West",
    :SW => "South West",
    :WSW => "West South West",
    :W => "West",
    :WNW => "West North West",
    :NW => "North West",
    :NNW => "North North West"
  }
  
  def meridian_indicator
    Time.parse(self.time).strftime("%p").downcase
  end
  
  def wind_dir_compass_long
    WIND_DIRECTIONS[self.wind_dir_compass.to_sym] if self.wind_dir_compass
  end
  
  def relative_humidity
    self.rh ? "#{self.rh}#{self.rh_units}" : "n/a"
  end
  
  def dew_point
    self.dp_c ? "#{self.dp_c}#{self.dp_c_units}" : "n/a"
  end
end