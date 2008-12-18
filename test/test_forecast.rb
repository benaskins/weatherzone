require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/forecast.rb'

class TestForecast < Test::Unit::TestCase

  def setup
    create_connection
    @forecast = Forecast.find("9770", :include => [:point_forecasts]).first
  end
  
  def test_should_exist
    assert @forecast.is_a?(Forecast)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    Forecast.fields.each do |e|
      assert_not_nil @forecast.send(e)
    end
  end

  def test_should_have_many_point_forecasts
    assert @forecast.point_forecasts.any?
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @forecast.nonsense_field
    end
  end

end
