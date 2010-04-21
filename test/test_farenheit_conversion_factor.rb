require File.dirname(__FILE__) + '/test_helper.rb'

class TestFarenheitConversionFactor < Test::Unit::TestCase

  C21_AS_F   = (BigDecimal("21") * BigDecimal("1.8")) + BigDecimal("32")
  C22P7_AS_F = (BigDecimal("22.7") * BigDecimal("1.8")) + BigDecimal("32")
  
  def setup
    keygen = lambda do
      eval(File.open(File.dirname(__FILE__) + '/../.wzkey.rb', 'r').read)      
    end
    @connection = Weatherzone::Connection.new(ENV['WZ_USER'], ENV['WZ_PASS'], keygen, :url => ENV['WZ_URL'], :timeout_after => 10)
    @connection.stubs(:request).returns( File.open("test/response/everything.xml") )
    weather     = Weather.find_by_location_code(@connection, "9770", :temperature_unit => "F")
    country     = weather.countries.first
    location    = country.locations.first
    @forecast   = location.forecasts.first
    @conditions = location.conditions.first
  end
  
  def test_forecast_should_convert_and_round_min_temp_value_to_integer
    assert_equal "#{C21_AS_F.round(0).to_i.to_s}", @forecast.temp_min_c_value
  end

  def test_forecast_should_convert_and_round_min_temp_value_with_units
    assert_equal "#{C21_AS_F.round(0).to_i.to_s}°F", @forecast.temp_min_c
  end

  def test_forecast_should_convert_min_temp_units
    assert_equal "°F", @forecast.temp_min_c_units
  end
  
  def test_conditions_should_convert_and_round_temp_value_to_one_decimal_place
    assert_equal "#{C22P7_AS_F.round(1).to_s('f')}", @conditions.temp_c_value
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
