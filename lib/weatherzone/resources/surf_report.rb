class SurfReport < Weatherzone::Resource
  has_elements :issue_day_name, :issue_time_local, :report_day_name, :report_time_local, :surf_summary_text, :wind_text, :weather_text, :summary
  
  element :image, :value => :url, :as => :image_url
end