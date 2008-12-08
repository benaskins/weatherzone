class Image < Weatherzone::Resource
  has_elements "issue_day_name", "issue_time_local", "valid_time", "text", "url"
  
  def self.find(location, options={})
    options[:image] = {:type => options[:type], :days => options[:days], :size => options[:size]}
    options[:params] = options[:params] || "code=#{location}"
    super(:image, options)
  end
end