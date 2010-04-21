require File.dirname(__FILE__) + '/test_helper.rb'

class TestConditions < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    @conditions = location.conditions.first
  end
  
  def test_should_be_a_conditions
    assert_kind_of Conditions, @conditions
  end

  def test_should_not_have_nil_attributes
    [:obs_time_utc, :obs_time_local, :temp_c, :dp_c, :rh, 
      :wind_dir_degrees, :wind_dir_compass, :wind_speed_kph, :wind_speed_kts,
      :wind_gust_kph, :wind_gust_kts, :feels_like_c, :rainfall_mm, :pressure_qnh_hpa].each do |attr_name|
      assert_not_nil @conditions.send(attr_name), "@conditions should respond to #{attr_name}"
    end
  end

  def test_should_have_units_attributes
    [:temp_c, :dp_c, :rh, :wind_dir_degrees, :wind_speed_kph, :wind_speed_kts, 
      :wind_gust_kph, :wind_gust_kts, :feels_like_c, :pressure_qnh_hpa, :rainfall_mm].each do |attr_name|
      assert_not_nil @conditions.send("#{attr_name}_units"), "@conditions should respond to #{attr_name}_units"
    end
  end

end
