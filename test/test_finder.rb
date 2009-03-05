require File.dirname(__FILE__) + '/test_helper.rb'

class TestFinder < Test::Unit::TestCase

  class SomeResource < Weatherzone::Resource
    include Weatherzone::Finder
  end

  def test_should_respond_to_find_by_location_code
    assert SomeResource.respond_to?(:find_by_location_code)
  end
  
  def test_should_build_parameters
    SomeResource.expects(:build_params).with(9770, :include => [:forecast])
    SomeResource.find_by_location_code(9770, :include => [:forecast])
  end

  def test_should_make_request
    Weatherzone::Connection.instance.expects(:request).returns( File.open("test/response/everything.xml") )
    SomeResource.find_by_location_code(9770, :include => [:forecast])
  end

  def test_should_parse_response
    f = File.open("test/response/everything.xml")
    Weatherzone::Connection.instance.stubs(:request).returns( f )
    SomeResource.expects(:parse).with(f)
    SomeResource.find_by_location_code(9770, :include => [:forecast])
  end

  def test_should_find_by_location_name
    SomeResource.expects(:build_params).with(nil, :params => "&lt=aploc&ln=Sydney%20NSW")
    SomeResource.find_by_location_name("Sydney NSW")
  end

  def test_should_find_by_location_filter
    SomeResource.expects(:build_params).with(nil, :params => "&lt=twcid&lf=twccapcity")
    SomeResource.find_by_location_filter("twccapcity")
  end

  def test_should_find_using_arbitrary_include
    SomeResource.expects(:build_params).with(nil, :include => [:moon_phases])
    SomeResource.find(:include => [:moon_phases])
  end
  
  def test_should_include_location_parameter_string
    assert_equal "&lc=9770", SomeResource.build_params(9770,{})
  end
  
  def test_should_include_forecasts
    assert_equal "&lc=9770&fc=1", SomeResource.build_params(9770, :include => [:forecasts])    
  end

  def test_should_include_point_forecasts
    assert_equal "&lc=9770&fc=3", SomeResource.build_params(9770, :include => [:point_forecasts])    
  end
  
  def test_should_include_district_forecasts
    assert_equal "&lc=9770&dist_fc=1", SomeResource.build_params(9770, :include => [:district_forecasts])    
  end
  
  def test_should_include_state_forecasts
    assert_equal "&lc=9770&state_fc=1", SomeResource.build_params(9770, :include => [:state_forecasts])    
  end

  def test_should_include_conditions
    assert_equal "&lc=9770&obs=1", SomeResource.build_params(9770, :include => [:conditions])    
  end

  def test_should_include_warnings
    assert_equal "&lc=9770&warn=2", SomeResource.build_params(9770, :include => [:warnings])    
  end

  def test_should_include_uv_index
    assert_equal "&lc=9770&uv=1", SomeResource.build_params(9770, :include => [:uv_index])    
  end

  def test_should_include_sun
    assert_equal "&lc=9770&fc_sun=2", SomeResource.build_params(9770, :include => [:sun])    
  end

  def test_should_include_moon
    assert_equal "&lc=9770&fc_moon=1", SomeResource.build_params(9770, :include => [:moon])    
  end
  
  def test_should_include_historical_observations
    assert_equal "&lc=9770&histobs=1", SomeResource.build_params(9770, :include => [:historical_observations])    
  end
  
  def test_should_include_daily_observations
    assert_equal "&lc=9770&dlyobs=7", SomeResource.build_params(9770, :include => [:daily_observations])    
  end

  def test_should_include_position
    assert_equal "&lc=9770&latlon=1", SomeResource.build_params(9770, :include => [:position])    
  end

  def test_should_include_moon_phases
    assert_equal "&moon=1", SomeResource.build_params(nil, :include => [:moon_phases])    
  end

  def test_should_include_news_items
    assert_equal "&news=2", SomeResource.build_params(nil, :include => [:news_items])    
  end
  
  def test_should_support_multiple_includes
    assert_equal "&lc=9770&fc=1&obs=1", SomeResource.build_params(9770, :include => [:forecasts, :conditions])    
  end
  
end
