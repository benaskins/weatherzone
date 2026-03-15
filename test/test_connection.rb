require File.dirname(__FILE__) + '/test_helper.rb'

class TestConnection < Test::Unit::TestCase

  def setup    
    keygen = Proc.new { 12345 }
    @connection = Weatherzone::Connection.new("username", "password", :keygen => keygen, :logger => Logger.new(nil))
  end

  def test_should_set_username
    assert_equal "username", @connection.username
  end

  def test_should_set_password
    assert_equal "password", @connection.password
  end

  def test_should_provide_base_url
    key = 12345 # On 20110101 the key should be this value
    hash = Digest::MD5.hexdigest "#{key}password"
    assert_equal "http://ws1.theweather.com.au/?u=username&k=#{hash}", @connection.base_url
  end
  
end
