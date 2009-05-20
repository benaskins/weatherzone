class Image < Weatherzone::Resource
  include Weatherzone::Helpers::DateParser
  has_elements :issue_day_name, :issue_time_local, :valid_time, :text, :url
  interpret_as_time :valid_time, :issue_time_local

  def forecast_date
    valid_time.to_date
  end
end