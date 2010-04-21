require File.dirname(__FILE__) + '/test_helper.rb'

class TestMarineSummary < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    @marine_forecast = location.marine_forecasts.first
    @marine_summary = @marine_forecast.marine_summaries.first
  end
  
  def test_should_be_a_marine_summary
    assert_kind_of MarineSummary, @marine_summary
  end

  def test_should_not_have_nil_attributes
    [:day, :day_name, :precis, :wind_dir_compass, :wind_speed_kts, :wind_speed_kph, :wind_speed_kts_units, :wind_speed_kph_units].each do |attr_name|
      assert_not_nil @marine_summary.send(attr_name), "@marine_summary should respond to #{attr_name}"
    end
  end

end
