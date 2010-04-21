require File.dirname(__FILE__) + '/test_helper.rb'

class TestWeather < Test::Unit::TestCase

  def setup
    keygen = lambda do
      eval(File.open(File.dirname(__FILE__) + '/../.wzkey.rb', 'r').read)      
    end
    @connection = Weatherzone::Connection.new(ENV['WZ_USER'], ENV['WZ_PASS'], keygen, :url => ENV['WZ_URL'], :timeout_after => 10)
    @connection.stubs(:request).returns( File.open("test/response/everything.xml")  )
    @weather = Weather.find_by_location_code(@connection, "9770")
  end
  
  def test_should_be_an_instance_of_weather
    assert_kind_of Weather, @weather
  end

  def test_should_have_countries
    assert @weather.countries.any?
  end
  
  def test_countries_should_be_countries
    assert_kind_of Country, @weather.countries.first
  end
  
end
