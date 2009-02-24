require File.dirname(__FILE__) + '/test_helper.rb'

class TestPointForecast < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_location("9770")
    country = weather.countries.first
    location = country.locations.first
    forecast = location.forecasts.first
    @point_forecast = forecast.point_forecasts.first
  end
  
  def test_should_be_a_point_forecast
    assert_kind_of PointForecast, @point_forecast
  end

  def test_should_not_have_nil_attributes
    [:dp_c, :rh, :wind_dir_degrees, :wind_dir_compass, :wind_speed_kph].each do |attr_name|
      assert_not_nil @point_forecast.send(attr_name), "@point_forecast should respond to #{attr_name}"
    end
  end

end
