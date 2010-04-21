require File.dirname(__FILE__) + '/test_helper.rb'

class TestStateForecast < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    @state_forecast = location.state_forecasts.first
  end
  
  def test_should_be_a_state_forecast
    assert_kind_of StateForecast, @state_forecast
  end

  def test_should_not_have_nil_attributes
    [:period, :period_name, :precis].each do |attr_name|
      assert_not_nil @state_forecast.send(attr_name), "@state_forecast should respond to #{attr_name}"
    end
  end

end
