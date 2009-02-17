class DailyObservation < Weatherzone::Resource

  has_elements "day_name", "date", "temp_min_c", "rainfall_mm"

  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&dlyobs=7"
    super(:daily_observations, options)
  end

end