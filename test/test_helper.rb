require 'test/unit'
require File.dirname(__FILE__) + '/../lib/weatherzone'

require 'weatherzone/resources/forecast'
require 'weatherzone/resources/point_forecast'
require 'weatherzone/resources/district_forecast'
require 'weatherzone/resources/state_forecast'
require 'weatherzone/resources/condition'
require 'weatherzone/resources/warning'
require 'weatherzone/resources/image'

class Test::Unit::TestCase

  # All tests will fail until you pass valid parameters to Weatherzone::Connection.connect
  #   1) Your weatherzone username
  #   2) Your weatherzone password
  #   3) A method for generating a valid weatherzone key
  #
  # The weatherzone connect method also accepts a :logger option, if you wish to see the urls generated to query the 
  # weatherzone webservice then please set this option.
  def create_connection
    Weatherzone::Connection.connect("<your-username>", "<your-password>") do
      "<your-sekret-keygen>"    
    end  
    verify_connection_parameters
  end

  # We don't want to attempt to run any tests unless these parameters have been set
  def verify_connection_parameters
    returning Weatherzone::Connection.instance do |connection|
      assert_not_equal "<your-username>", connection.username, "You haven't set a username"
      assert_not_equal "<your-password>", connection.password, "You haven't set a password"
      assert_not_equal "<your-sekret-keygen>", connection.key, "You haven't set a keygen"
    end
  end

end
