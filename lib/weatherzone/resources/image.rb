class Image < Weatherzone::Resource
  has_elements :issue_day_name, :issue_time_local, :valid_time, :text, :url
end