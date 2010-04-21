require File.dirname(__FILE__) + '/test_helper.rb'

class TestAlmanacPeriod < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    almanac = location.almanacs.first
    @almanac_period = almanac.almanac_periods.first
  end
  
  def test_should_be_a_almanac_period
    assert_kind_of AlmanacPeriod, @almanac_period
  end

  def test_should_not_have_nil_attributes
    [:code, :title, :month_name, :from, :to].each do |attr_name|
      assert_not_nil @almanac_period.send(attr_name), "@almanac_period should respond to #{attr_name}"
    end
  end

  def test_should_have_accessors_for_attributes_setup_with_the_almanac_element_helper
    # Just testing a representative sample as there are 80 odd accessors that get added to the AlmanacPeriod resource in this way
    [:avg_rainfall_this_month, :avg_rainfall_this_month_value, :avg_rainfall_this_month_units, :avg_rainfall_this_month_days,
     :avg_rainfall_this_year, :avg_rainfall_this_year_value, :avg_rainfall_this_year_units, :avg_rainfall_this_year_days].each do |attr_name|
      assert @almanac_period.respond_to?(attr_name), "@almanac_period should respond to #{attr_name}"
      assert @almanac_period.respond_to?("#{attr_name}="), "@almanac_period should respond to #{attr_name}="
    end
  end

end
