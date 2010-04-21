require File.dirname(__FILE__) + '/test_helper.rb'

class TestBuoyObservation < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    @buoy_observation = location.buoy_observations.first
  end
  
  def test_should_be_a_tide
    assert_kind_of BuoyObservation, @buoy_observation
  end

  def test_should_not_have_nil_attributes
    [:day_name, :time, :wave_height_m_significant, :wave_height_m_max, :wave_height_m_units, :wave_height_ft_significant, :wave_height_ft_max, :wave_height_ft_units,
      :wave_period_significant, :wave_period_peak, :wave_period_units, :wave_dir_degrees, :wave_dir_degrees_units, :wave_dir_compass, :sea_temp_c, :sea_temp_c_units].each do |attr_name|
      assert_not_nil @buoy_observation.send(attr_name), "@buoy_observation should respond to #{attr_name}"
    end
  end

end
