require File.dirname(__FILE__) + '/test_helper.rb'

class TestConnection < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.connect("username", "password") do
      "sekret" + Weatherzone::Connection.instance.password
    end
    @connection = Weatherzone::Connection.instance
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
    assert_equal "http://webservice.theweather.com.au/ws1/wx.php?u=username&k=sekretpassword", @connection.base_url
  end
  
end
