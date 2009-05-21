require File.dirname(__FILE__) + '/test_helper.rb'

class TestTide < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code("9770")
    country = weather.countries.first
    location = country.locations.first
    @tide = location.tides.first
  end
  
  def test_should_be_a_tide
    assert_kind_of Tide, @tide
  end

  def test_should_not_have_nil_attributes
    [:day_name, :time, :tide_type, :tide_height_m, :tide_height_m_units, :time_tz].each do |attr_name|
      assert_not_nil @tide.send(attr_name), "@tide should respond to #{attr_name}"
    end
  end

end
