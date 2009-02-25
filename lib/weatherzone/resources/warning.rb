class Warning < Weatherzone::Resource
  attributes :id, :type
  has_elements :issue_day_name, :issue_time_local, :expire_time_local, :short_text, :url

  # Override id and type
  attr_reader :id, :type
end