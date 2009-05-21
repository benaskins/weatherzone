class MarineSummary < Weatherzone::Resource
  include Weatherzone::Helpers::Units
  
  attributes :day
  has_elements :day, :day_name, :precis, :wind_dir_compass, :wind_speed_kts, :wind_speed_kph
  has_attribute :units, :on_elements => [:wind_speed_kts, :wind_speed_kph]
  value_plus_unit_readers :wind_speed_kts, :wind_speed_kph
end