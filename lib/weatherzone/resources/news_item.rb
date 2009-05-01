class NewsItem < Weatherzone::Resource

  include Weatherzone::Helpers::DateParser
  
  attributes :item_num, :source
  has_elements :link, :title, :byline, :dateline, :creditline, :copyright, :text
  has_attribute :type, :on_elements => :link
  has_attribute :description, :on_elements => :link
  has_attribute :url, :on_elements => :link
  has_attribute :date, :on_elements => [:dateline, :copyright]

  interpret_as_date :dateline_date

  def copyright_line
    "&copy; #{copyright} #{copyright_date}"
  end

end