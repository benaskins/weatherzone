class Forecast < Weatherzone::Resource
  has_elements "day_name", "date", "temp_min_c", "temp_max_c", "prob_precip", "icon"
  
  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&fc=1"
    super(:forecast, options)
  end
end