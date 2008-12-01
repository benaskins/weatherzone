class Forecast < Weatherzone::Resource
  has_elements "day_name", "date", "temp_min_c", "temp_max_c", "prob_precip", "icon"
  
  def self.find(location)
    super(:forecast, "lc=#{location}&fc=1")
  end
end