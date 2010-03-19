require File.dirname(__FILE__) + '/test_helper.rb'

class TestFileParser < Test::Unit::TestCase

  def setup
    @weather = Weather.parse_file("test/response/everything.xml")
  end
  
  def test_should_be_an_instance_of_weather
    assert_kind_of Weather, @weather
  end

  def test_should_have_countries
    assert @weather.countries.any?
  end
  
  def test_countries_should_be_countries
    assert_kind_of Country, @weather.countries.first
  end
  
end
