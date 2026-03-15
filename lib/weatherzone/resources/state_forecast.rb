module Weatherzone
  class StateForecast < Weatherzone::Resource
    attribute :period
    has_elements :period_name, :precis
  end
end