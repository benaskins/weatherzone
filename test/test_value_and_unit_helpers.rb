require File.dirname(__FILE__) + '/test_helper.rb'

class TestForecast < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.connect("username", "password") do
      "sekret" + Weatherzone::Connection.instance.password
    end
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/everything.xml") )
    weather = Weather.find_by_location_code("9770")
    country = weather.countries.first
    location = country.locations.first
    @forecast = location.forecasts.first
  end
  
  def test_should_have_min_temp_value
    assert_equal "21", @forecast.temp_min_c_value
  end

  def test_should_have_min_temp_value_with_units
    assert_equal "21°C", @forecast.temp_min_c
  end

  def test_should_have_min_temp__units
    assert_equal "°C", @forecast.temp_min_c_units
  end

end
