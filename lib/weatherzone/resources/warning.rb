class Warning < Weatherzone::Resource
  has_elements "issue_day_name", "issue_time_local", "expire_time_location", "short_text", "url"
  
  def self.find(location, options={})
    options[:params] = options[:params] || "code=#{location}&warn=1"
    super(:warning, options)
  end
end