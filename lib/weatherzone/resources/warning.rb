class Warning < Weatherzone::Resource
  has_elements :issue_day_name, :issue_time_local, :expire_time_local, :short_text, :url
end