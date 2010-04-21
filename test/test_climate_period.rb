require File.dirname(__FILE__) + '/test_helper.rb'

class TestClimatePeriod < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    @climate_period = location.climate_periods.first
  end
  
  def test_should_be_a_climate_period
    assert_kind_of ClimatePeriod, @climate_period
  end

  def test_should_not_have_nil_attributes
    [:name, :mean_temp_min_c, :mean_temp_max_c, :rain_days, :mean_rainfall_mm].each do |attr_name|
      assert_not_nil @climate_period.send(attr_name), "@climate_period should respond to #{attr_name}"
    end
  end
  
  def test_should_have_units_attributes
    [:mean_temp_min_c, :mean_temp_max_c, :mean_rainfall_mm].each do |attr_name|
      assert_not_nil @climate_period.send("#{attr_name}_units"), "@climate_period should respond to #{attr_name}_units"
    end
  end

end
