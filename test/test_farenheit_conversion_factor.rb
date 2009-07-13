require File.dirname(__FILE__) + '/test_helper.rb'

class TestFarenheitConversionFactor < Test::Unit::TestCase

  C21_AS_F = (21 * 1.8) + 32
  
  def setup
    Weatherzone::Connection.connect("username", "password") do
      "sekret" + Weatherzone::Connection.instance.password
    end
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/everything.xml") )
    weather = Weather.find_by_location_code("9770", :temperature_unit => "F")
    country = weather.countries.first
    location = country.locations.first
    @forecast = location.forecasts.first
  end
  
  def test_should_have_min_temp_value
    assert_equal "#{C21_AS_F}", @forecast.temp_min_c_value
  end

  def test_should_have_min_temp_value_with_units
    assert_equal "#{C21_AS_F}°F", @forecast.temp_min_c
  end

  def test_should_have_min_temp__units
    assert_equal "°C", @forecast.temp_min_c_units
  end

end
