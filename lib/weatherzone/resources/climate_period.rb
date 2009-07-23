class ClimatePeriod < Weatherzone::Resource
  include Weatherzone::Helpers::Units
  attributes :name
  has_elements :mean_temp_min_c, :mean_temp_max_c, :rain_days, :mean_rainfall_mm
  has_attribute :units, :on_elements => [:mean_temp_min_c, :mean_temp_max_c, :mean_rainfall_mm]
  temperature :mean_temp_min_c, :mean_temp_max_c
  value_plus_unit_readers :mean_rainfall_mm
end