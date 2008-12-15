require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/state_forecast.rb'

class TestStateForecast < Test::Unit::TestCase

  def setup
    create_connection
    @state_forecast = StateForecast.find("9770").first
  end
  
  def test_should_exist
    assert @state_forecast.is_a?(StateForecast)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    StateForecast.fields.each do |e|
      assert_not_nil @state_forecast.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @state_forecast.nonsense_field
    end
  end

end
