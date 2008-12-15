class PointForecast < Weatherzone::Resource

  has_elements "dp_c", "rh", "wind_dir_degrees", "wind_dir_compass", "wind_speed_kph"
  
  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&fc=3"
    super(:point_forecast, options)
  end
end