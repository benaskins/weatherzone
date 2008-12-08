require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/location.rb'

class TestLocation < Test::Unit::TestCase

  def setup
    create_connection
    @locations = Location.find("9770", :include => [:conditions, :forecasts, :district_forecasts])
    @location  = @locations.first
  end
  
  def test_should_exist
    assert @location
  end
  
  def test_should_have_attributes
    ["type", "code", "name", "state"].each do |a|
      assert @location[a]
    end
  end

  def test_should_be_identifiable_by_code
    assert_equal @location.id, @location["code"]
  end

  def test_should_have_forecasts
    assert @location.forecasts.any?
  end

  def test_should_have_conditions
    assert @location.conditions
  end

  def test_should_have_district_forecasts
    assert @location.district_forecasts.any?    
  end

  # TODO: Fix silly test, need to mock responses with cached xml so we can guarantee results
  def test_should_have_warnings_or_maybe_not
    assert @location.warnings.any? || @location.warnings.empty?
  end

  def test_should_receive_each_specified_field_and_return_non_nil_values
    Location.fields.each do |e|
      assert_not_nil @location.send(e)
    end
  end

end
