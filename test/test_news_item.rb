require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/news_item.rb'

class TestNewsItem < Test::Unit::TestCase

  def setup
    create_connection
    @news_items = NewsItem.all
    @first_item = @news_items.first
  end
    
  def test_should_receive_each_specified_field_and_return_non_nil_values
    NewsItem.fields.each do |e|
      assert_not_nil @first_item.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @first_item.nonsense_field
    end
  end

end
