require File.dirname(__FILE__) + '/test_helper.rb'

class TestCountry < Test::Unit::TestCase

  def setup
    keygen = lambda do
      eval(File.open(File.dirname(__FILE__) + '/../.wzkey.rb', 'r').read)      
    end
    @connection = Weatherzone::Connection.new(ENV['WZ_USER'], ENV['WZ_PASS'], keygen, :url => ENV['WZ_URL'], :timeout_after => 10)    
    @connection.stubs(:request).returns( File.open("test/response/everything.xml")  )
    weather = Weather.find_by_location_code(@connection, "9770")
    @country = weather.countries.first
  end
  
  def test_should_be_a_country
    assert_kind_of Country, @country
  end

  def test_should_not_have_nil_attributes
    [:code, :name].each do |attr_name|
      assert @country.send(attr_name), "@country should respond to #{attr_name}"
    end
  end
  
  def test_should_have_locations
    assert @country.locations.any?
  end

  def test_locations_should_be_locations
    assert_kind_of Location, @country.locations.first
  end
  
end
