require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/historical_observation.rb'

class TestHistoricalObservtion < Test::Unit::TestCase

  def setup
    create_connection
    @historical_observation = HistoricalObservation.find("9770").first
  end
  
  def test_should_exist
    assert @historical_observation.is_a?(HistoricalObservation)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    HistoricalObservation.fields.each do |e|
      assert_not_nil @historical_observation.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @historical_observation.nonsense_field
    end
  end

end
