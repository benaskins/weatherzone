require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/daily_observation.rb'

class TestDailyObservtion < Test::Unit::TestCase

  def setup
    create_connection
    @daily_observation = DailyObservation.find("9770").first
  end
  
  def test_should_exist
    assert @daily_observation.is_a?(DailyObservation)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    DailyObservation.fields.each do |e|
      assert_not_nil @daily_observation.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @daily_observation.nonsense_field
    end
  end

end
