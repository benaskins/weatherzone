require File.dirname(__FILE__) + '/test_helper.rb'

class TestValueAndUnitHelpers < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.connect("username", "password") do
      "sekret" + Weatherzone::Connection.instance.password
    end
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/everything.xml") )
    weather     = Weather.find_by_location_code("9770")
    country     = weather.countries.first
    location    = country.locations.first
    @forecast   = location.forecasts.first
    @conditions = location.conditions.first
  end
  
  def test_forecast_should_have_min_temp_value
    assert_equal "21", @forecast.temp_min_c_value
  end

  def test_forecast_should_have_min_temp_value_with_units
    assert_equal "21°C", @forecast.temp_min_c
  end

  def test_forecast_should_have_min_temp_units
    assert_equal "°C", @forecast.temp_min_c_units
  end

  def test_conditions_should_have_rainfall_value
    assert_equal "0.0", @conditions.rainfall_mm_value
  end

  def test_conditions_should_have_rainfall_value_with_units
    assert_equal "0.0mm", @conditions.rainfall_mm
  end

  def test_conditions_should_have_rainfall_units
    assert_equal "mm", @conditions.rainfall_mm_units
  end

end
