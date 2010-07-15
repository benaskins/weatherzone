require 'weatherzone/resources/lift'
require 'weatherzone/resources/camera'

class SnowReport < Weatherzone::Resource
  has_elements :day_name, :issue_time_local, :visibility_text, :road_conditions, :primary_surface, :snow_conditions, :snow_cover, :snow_depth_avg_cm, :snow_depth_new_cm, 
      :snow_making, :grooming, :last_snowfall_date, :resort_summary, :lifts_open
  elements :lift, :as => :lifts, :class => Lift
  elements :cam, :as => :cameras, :class => Camera
end
