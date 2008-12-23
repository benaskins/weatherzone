require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/moon_phase.rb'

class TestMoonPhase < Test::Unit::TestCase

  def setup
    create_connection
    @moon_phases = MoonPhase.all
    @first_phase = @moon_phases.first
  end
  
  def test_should_be_four_phases
    assert_equal 4, @moon_phases.length
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    MoonPhase.fields.each do |e|
      assert_not_nil @first_phase.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @first_phase.nonsense_field
    end
  end

end
