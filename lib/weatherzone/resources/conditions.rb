class Conditions < Weatherzone::Resource  

  include Weatherzone::Helpers::Units
  
  has_elements :obs_time_utc, :obs_time_local, :temp_c, :dp_c, :rh, 
    :wind_dir_degrees, :wind_dir_compass, :wind_speed_kph, :wind_speed_kts,
    :wind_gust_kph, :wind_gust_kts, :feels_like_c, :rainfall_mm, :pressure_qnh_hpa

  has_attribute :units, :on_elements => [:temp_c, :dp_c, :rh, :wind_dir_degrees, :wind_speed_kph, :wind_speed_kts, 
                                          :wind_gust_kph, :wind_gust_kts, :feels_like_c, :pressure_qnh_hpa, :rainfall_mm]
  has_attribute :period, :on_elements => :rainfall_mm

  value_plus_unit_readers :temp_c, :dp_c, :rh, :wind_speed_kph, :wind_speed_kts, :wind_gust_kph, :wind_gust_kts, :feels_like_c, :rainfall_mm, :pressure_qnh_hpa

  def wind_dir_and_speed
    wind_dir_compass || wind_speed_kph ? "#{wind_dir_compass} #{wind_speed_kph}" : nil
  end
end