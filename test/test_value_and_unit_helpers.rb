require File.dirname(__FILE__) + '/test_helper.rb'

class TestValueAndUnitHelpers < Test::Unit::TestCase

  def setup
    keygen = lambda do
      eval(File.open(File.dirname(__FILE__) + '/../.wzkey.rb', 'r').read)      
    end
    @connection = Weatherzone::Connection.new(ENV['WZ_USER'], ENV['WZ_PASS'], keygen, :url => ENV['WZ_URL'], :timeout_after => 10)
    @connection.stubs(:request).returns( File.open("test/response/everything.xml") )
    weather     = Weather.find_by_location_code(@connection, "9770")
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
  
  def test_conditions_should_have_temp_value
    assert_equal "22.7", @conditions.temp_c_value    
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
