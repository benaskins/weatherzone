require File.dirname(__FILE__) + '/test_helper.rb'

class TestLocation < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code("9770")
    country = weather.countries.first
    @location = country.locations.first
  end
  
  def test_should_be_a_location
    assert_kind_of Location, @location
  end

  def test_should_not_have_nil_attributes
    [:type, :code, :name, :state, :lat, :long, :elevation, :lat_units, :long_units, :elevation_units].each do |attr_name|
      assert_not_nil @location.send(attr_name), "@location should respond to #{attr_name}"
    end
  end

  def test_should_be_identifiable_by_code
    assert_equal @location.id, @location.code
  end
  
  def test_should_have_forecasts
    assert @location.forecasts.any?
  end
  
  def test_should_have_conditions
    assert @location.conditions.any?
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
  
  def test_should_have_daily_observations
    assert @location.daily_observations.any?    
  end
  
  def test_should_have_warnings
    assert @location.warnings.any?
  end
  
  def test_should_have_images
    assert @location.synoptic_charts.any?
  end

  def test_should_have_almanacs
    assert @location.almanacs.any?
  end
  
end
