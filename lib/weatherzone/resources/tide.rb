class Tide < Weatherzone::Resource
  include Weatherzone::Helpers::Units
  include Weatherzone::Helpers::DateParser
  
  has_elements :day_name, :time, :tide_type, :tide_height_m
  has_attribute :units, :on_elements => [:tide_height_m]
  value_plus_unit_readers :tide_height_m
  interpret_as_time :time
end