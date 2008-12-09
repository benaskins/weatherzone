require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/forecast.rb'

class TestForecast < Test::Unit::TestCase

  def setup
    create_connection
    @forecast = Forecast.find("9770").first
  end
  
  def test_should_exist
    assert @forecast.is_a?(Forecast)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    Forecast.fields.each do |e|
      assert_not_nil @forecast.send(e)
    end
  end

end
