require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/condition.rb'

class TestCondition < Test::Unit::TestCase

  def setup
    create_connection
    @conditions = Condition.find("9770").first
  end
  
  def test_should_exist
    assert @conditions.is_a?(Condition)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    Condition.fields.each do |e|
      assert_not_nil @conditions.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @conditions.nonsense_field
    end
  end

end
