class StateForecast < Weatherzone::Resource
  attributes :period
  has_elements :period_name, :precis
end