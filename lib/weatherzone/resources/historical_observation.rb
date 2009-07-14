class HistoricalObservation < Weatherzone::Resource

  include Weatherzone::Helpers::Units
  
  has_elements :obs_time_utc, :obs_time_local, :temp_c, :dp_c, :rh, 
    :wind_dir_degrees, :wind_dir_compass, :wind_speed_kph, :wind_speed_kts,
    :wind_gust_kph, :wind_gust_kts, :feels_like_c, :rainfall_mm, :pressure_qnh_hpa
  has_attribute :units, :on_elements => [:temp_c, :dp_c, :rh, :wind_dir_degrees, :wind_speed_kph, 
                                          :wind_speed_kts, :wind_gust_kph, :wind_gust_kts, :feels_like_c, :rainfall_mm, :pressure_qnh_hpa, :rainfall_mm]
  has_attribute :period, :on_elements => :rainfall_mm
  
  temperature :temp_c
  
  WIND_SPEED_RANGE = {
    (0..19) => "calm",                                                                                       
    (20..30) => "moderate",
    (31..39) => "fresh",
    (40..61) => "strong",
    (62..87) => "gale",
    (88..1.0/0) => "storm"
  }
  
  WIND_SPEED_RANGE.instance_eval do
    def find_by_speed(speed)
      self[keys.find { |range| range.include? speed.to_i }] rescue nil    
    end
  end
  
  def obs_time_local
    Time.parse(@obs_time_local)
  end
  
  def is_on_the_half_hour?
    obs_time_local.change(:min => 0) == obs_time_local || obs_time_local.change(:min => 30) == obs_time_local
  end
  
  def is_on_the_hour?
    obs_time_local.change(:min => 0) == obs_time_local
  end
  
  def wind_speed
    WIND_SPEED_RANGE.find_by_speed(wind_speed_kph)
  end
  
  def rainfall_mm
    @rainfall_mm || "0"
  end
  
  def hash
    obs_time_local.hash
  end

  def eql?(other)
    self.obs_time_local == other.obs_time_local
  end

end