require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/district_forecast.rb'

class TestDistrictForecast < Test::Unit::TestCase

  def setup
    create_connection
    @district_forecast = DistrictForecast.find("9770").first
  end
  
  def test_should_exist
    assert @district_forecast.is_a?(DistrictForecast)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    DistrictForecast.fields.each do |e|
      assert_not_nil @district_forecast.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @district_forecast.nonsense_field
    end
  end

end
