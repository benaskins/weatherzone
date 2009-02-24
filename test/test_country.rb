require File.dirname(__FILE__) + '/test_helper.rb'

class TestCountry < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/everything.xml")  )
    weather = Weather.find_location("9770")
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
