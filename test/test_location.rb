require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/location.rb'
require 'mocha'

class TestLocation < Test::Unit::TestCase

  def setup
    create_connection
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/locations.xml") { |f| Hpricot.XML(f) } )
    @locations = Location.find("9770", 
                  :include => [:conditions, :forecasts, :district_forecasts, :state_forecasts, :historical_observations], 
                  :image => {:size => "640x480", :days => 0, :type => "syn"},
                  :days => 1
                 )
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

  def test_should_have_state_forecasts
    assert @location.district_forecasts.any?    
  end

  def test_should_have_historical_observations
    assert @location.historical_observations.any?    
  end

  def test_should_have_warnings_or_maybe_not
    assert @location.warnings.any?
  end

  def test_should_only_have_one_day_for_each_forecast_type
    assert_equal 1, @location.forecasts.length
  end

  def test_should_have_images
    assert @location.images.any?
  end

  def test_should_receive_each_specified_field_and_return_non_nil_values
    Location.fields.each do |e|
      assert_not_nil @location.send(e)
    end
  end


  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @location.nonsense_field
    end
  end

end
