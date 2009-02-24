require File.dirname(__FILE__) + '/test_helper.rb'

class TestForecast < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_location("9770")
    country = weather.countries.first
    location = country.locations.first
    @forecast = location.forecasts.first
  end
  
  def test_should_be_a_forecast
    assert_kind_of Forecast, @forecast
  end

  def test_should_not_have_nil_attributes
    [:day_name, :date, :temp_min_c, :temp_max_c, :prob_precip, :icon,
      :rain_range_text, :frost_risk_text, :uv, :first_light, :sunrise, :sunset, :last_light,
      :moonrise, :moonset, :moon_phase_phase_text, :moon_phase_phase_num, :moon_phase_image_name, 
      :temp_min_c_units, :temp_max_c_units, :prob_precip_units, :uv_index, :icon_filename].each do |attr_name|
      assert_not_nil @forecast.send(attr_name), "@forecast should respond to #{attr_name}"
    end
  end

  def test_should_have_many_point_forecasts
    assert @forecast.point_forecasts.any?
  end

end
