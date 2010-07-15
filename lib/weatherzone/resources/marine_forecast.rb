require 'weatherzone/resources/marine_summary'

class MarineForecast < Weatherzone::Resource
  include Weatherzone::Helpers::Units
  
  has_elements :issue_day_name, :issue_time_local, :short_text, :long_text, :sea_height_m, :sea_height_text, :swell_height_m, :swell_dir_compass
  has_attribute :units, :on_elements => [:sea_height_m, :swell_height_m]
  value_plus_unit_readers :sea_height_m, :swell_height_m

  elements :marine_summary, :as => :marine_summaries, :class => MarineSummary
end
