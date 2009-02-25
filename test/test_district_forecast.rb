require File.dirname(__FILE__) + '/test_helper.rb'

class TestDistrictForecast < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_location("9770")
    country = weather.countries.first
    location = country.locations.first
    @district_forecast = location.district_forecasts.first
  end
  
  def test_should_be_a_district_forecast
    assert_kind_of DistrictForecast, @district_forecast
  end

  def test_should_not_have_nil_attributes
    [:period, :period_name, :precis, :icon, :icon_filename].each do |attr_name|
      assert_not_nil @district_forecast.send(attr_name), "@district_forecast should respond to #{attr_name}"
    end
  end

end
