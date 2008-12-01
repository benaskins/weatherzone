require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/location.rb'

class TestCapitalCityFinder < Test::Unit::TestCase

  def setup
    create_connection
    @locations = Location.capital_cities
  end
  
  def test_should_exist
    assert @locations.any?
  end

end
