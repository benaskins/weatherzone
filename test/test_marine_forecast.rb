require File.dirname(__FILE__) + '/test_helper.rb'

class TestMarineForecast < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code("9770")
    country = weather.countries.first
    location = country.locations.first
    @marine_forecast = location.marine_forecasts.first
  end
  
  def test_should_be_a_marine_forecast
    assert_kind_of MarineForecast, @marine_forecast
  end

  def test_should_not_have_nil_attributes
    [:issue_day_name, :issue_time_local, :short_text, :long_text, :sea_height_m, :sea_height_text, :swell_height_m, :swell_dir_compass].each do |attr_name|
      assert_not_nil @marine_forecast.send(attr_name), "@marine_forecast should respond to #{attr_name}"
    end
  end

  def test_should_have_marine_summaries
    assert @marine_forecast.marine_summaries.any?
  end

end
