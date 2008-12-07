class DistrictForecast < Weatherzone::Resource
  has_elements "period_name", "precis", "icon"
  
  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&dist_fc=1"
    super(:district_forecast, options)
  end
end