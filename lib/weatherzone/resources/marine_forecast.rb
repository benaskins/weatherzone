class MarineForecast < Weatherzone::Resource
  include Weatherzone::Helpers::Units
  
  has_elements :issue_day_name, :issue_time_local, :short_text, :long_text, :sea_height_m, :sea_height_text, :swell_height_m, :swell_dir_compass
  value_plus_unit_readers :sea_height_m, :swell_height_m
end