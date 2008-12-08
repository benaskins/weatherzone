class StateForecast < Weatherzone::Resource
  has_elements "period_name", "precis"
  
  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&state_fc=1"
    super(:state_forecast, options)
  end
end