require File.dirname(__FILE__) + '/test_helper.rb'

class TestNewsItem < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/news.xml") )
    weather = Weather.find_by_location_code("9770")
    @news_items = weather.news_items
    @news_item = @news_items.first
  end
  
  def test_should_be_a_news_item
    assert_kind_of NewsItem, @news_item
  end

  def test_should_not_have_nil_attributes
    [:link_url, :title, :byline, :dateline, :creditline, :copyright, :text, :dateline_date, :copyright_date, :link_type, :link_description].each do |attr_name|
      assert_not_nil @news_item.send(attr_name), "@news_item should respond to #{attr_name}"
    end
  end
  
end
