require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/point_forecast.rb'

class TestPointForecast < Test::Unit::TestCase

  def setup
    create_connection
    @point_forecast = PointForecast.find("9770").first
  end
  
  def test_should_exist
    assert @point_forecast.is_a?(PointForecast)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    PointForecast.fields.each do |e|
      assert_not_nil @point_forecast.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @point_forecast.nonsense_field
    end
  end

end
