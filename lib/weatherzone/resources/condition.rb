class Condition < Weatherzone::Resource  
  has_elements "obs_time_utc", "obs_time_local", "temp_c", "dp_c", "rh", 
    "wind_dir_degrees", "wind_dir_compass", "wind_speed_kph", "wind_speed_kts",
    "wind_gust_kph", "wind_gust_kts", "feels_like_c", "rainfall_mm", "pressure_qnh_hpa"

  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&obs=1"
    super(:conditions, options)
  end

  def rainfall
    rainfall_mm.available? ? "#{self.rainfall_mm}#{self.rainfall_mm[:units]}" : "n/a"
  end

end