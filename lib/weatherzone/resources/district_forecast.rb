class DistrictForecast < Weatherzone::Resource
  attributes :period
  has_elements :period_name, :precis, :icon
  has_attribute :filename, :on_elements => :icon
end