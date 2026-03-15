require File.dirname(__FILE__) + '/test_helper.rb'

class TestResponseParser < Test::Unit::TestCase

  def setup
    response = File.open("test/response/everything.xml")
    @weather = Weatherzone::Weather.parse(response)
  end
  
  def test_should_be_an_instance_of_weather
    assert_kind_of Weatherzone::Weather, @weather
  end

  def test_should_have_countries
    assert @weather.countries.any?
  end
  
  def test_countries_should_be_countries
    assert_kind_of Weatherzone::Country, @weather.countries.first
  end
  
end
