require File.dirname(__FILE__) + '/test_helper.rb'

class TestConnection < Test::Unit::TestCase

  def setup
    keygen = lambda { "sekret" + password }
    @connection = Weatherzone::Connection.new("username", "password", keygen, :url => "http://ws1.theweather.com.au/")
  end

  def test_should_set_username
    assert_equal "username", @connection.username
  end

  def test_should_set_password
    assert_equal "password", @connection.password
  end

  def test_should_set_key
    assert_equal "sekretpassword", @connection.key
  end

  def test_should_provide_base_url
    assert_equal "http://ws1.theweather.com.au/?u=username&k=sekretpassword", @connection.base_url
  end
  
end
