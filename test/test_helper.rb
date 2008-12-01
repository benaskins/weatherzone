require 'test/unit'
require File.dirname(__FILE__) + '/../lib/weatherzone'

class Test::Unit::TestCase

  # All tests will fail until you set three instance variables on the connection instance:
  #   1) Your weatherzone username
  #   2) Your weatherzone password
  #   3) A method for generating a valid weatherzone key
  def create_connection
    Weatherzone::Connection.connect("<your-username>", "<your-password>") do
      "<your-sekret-keygen>"
    end
    verify_connection_parameters
  end

  # We don't want to attempt to run any tests unless these parameters have been set
  def verify_connection_parameters
    connection = Weatherzone::Connection.instance
    assert_not_equal "<your-username>", connection.username, "You haven't set a username"
    assert_not_equal "<your-password>", connection.password, "You haven't set a password"
    assert_not_equal "<your-sekret-keygen>", connection.key, "You haven't set a keygen"
  end

end
