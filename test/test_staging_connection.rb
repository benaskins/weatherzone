require File.dirname(__FILE__) + '/test_helper.rb'

class TestConnection < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.connect("username", "password", :environment => "staging") do
      "sekret" + Weatherzone::Connection.instance.password
    end
    @connection = Weatherzone::Connection.instance
  end

  def test_should_provide_base_url
    assert_equal "http://webservice.staging.theweather.com.au/ws1/wx.php?u=username&k=sekretpassword", @connection.base_url
  end
  
end
