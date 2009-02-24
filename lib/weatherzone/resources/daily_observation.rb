class DailyObservation < Weatherzone::Resource
  has_elements :day_name, :date, :temp_min_c, :rainfall_mm
end