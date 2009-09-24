class BuoyObservation < Weatherzone::Resource
  include Weatherzone::Helpers::Units
  include Weatherzone::Helpers::DateParser
  
  has_elements :day_name, :time, :wave_height_m, :wave_height_ft, :wave_period, :wave_dir_degrees, :wave_dir_compass, :sea_temp_c
  has_attribute :units, :on_elements => [:wave_height_m, :wave_height_ft, :wave_period, :wave_dir_degrees, :sea_temp_c]
  has_attribute :significant, :on_elements => [:wave_height_m, :wave_height_ft, :wave_period]
  has_attribute :max, :on_elements => [:wave_height_m, :wave_height_ft]
  has_attribute :peak, :on_elements => [:wave_period]
  value_plus_unit_readers :wave_height_m, :wave_height_ft, :wave_period, :wave_dir_degrees, :sea_temp_c
  # interpret_as_time :time
end