module Weatherzone
  class DistrictForecast < Weatherzone::Resource
    attribute :period
    has_elements :period_name, :precis, :icon
    has_attribute :filename, :on_elements => :icon
  end
end