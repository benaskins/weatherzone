class NewsItem < Weatherzone::Resource
  has_elements "link", "title", "byline", "dateline", "creditline", "copyright", "text"
  
  def self.all(options={})
    options[:params] = options[:params] || "&news=1"
    find(:news_item, options)
  end
end