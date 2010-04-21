require File.dirname(__FILE__) + '/test_helper.rb'

class TestAlmanac < Test::Unit::TestCase
  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    @almanac = location.almanacs.first
  end
  
  def test_should_be_a_almanac
    assert_kind_of Almanac, @almanac
  end

  def test_should_not_have_nil_attributes
    [:month_num, :month_name, :date_start, :date_end].each do |attr_name|
      assert_not_nil @almanac.send(attr_name), "@almanac should respond to #{attr_name}"
    end
  end

  def test_should_have_many_almanac_periods
    assert @almanac.almanac_periods.any?
  end
end
