class NewsItem < Weatherzone::Resource
  has_elements :link, :title, :byline, :dateline, :creditline, :copyright, :text
  has_attribute :url, :on_elements => :link
end