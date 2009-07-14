require File.dirname(__FILE__) + '/test_helper.rb'

class TestFarenheitConversionFactor < Test::Unit::TestCase

  C21_AS_F = (21 * 1.8) + 32
  
  def setup
    Weatherzone::Connection.connect("username", "password") do
      "sekret" + Weatherzone::Connection.instance.password
    end
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/everything.xml") )
    weather     = Weather.find_by_location_code("9770", :temperature_unit => "F")
    country     = weather.countries.first
    location    = country.locations.first
    @forecast   = location.forecasts.first
    @conditions = location.conditions.first
  end
  
  def test_forecast_should_convert_min_temp_value
    assert_equal "#{C21_AS_F}", @forecast.temp_min_c_value
  end

  def test_forecast_should_convert_min_temp_value_with_units
    assert_equal "#{C21_AS_F}°F", @forecast.temp_min_c
  end

  def test_forecast_should_convert_min_temp_units
    assert_equal "°F", @forecast.temp_min_c_units
  end
  
  def test_conditions_should_not_convert_rainfall_value
    assert_equal "0.0", @conditions.rainfall_mm_value
  end

  def test_conditions_should_not_convert_rainfall_value_with_units
    assert_equal "0.0mm", @conditions.rainfall_mm
  end

  def test_conditions_should_not_convert_rainfall_units
    assert_equal "mm", @conditions.rainfall_mm_units
  end
  
end
