require File.dirname(__FILE__) + '/support/dependencies.rb'

class Test::Unit::TestCase
  def setup
    @connection = Weatherzone::Connection.new("username", "password", :timeout_after => 10, :logger => Logger.new(nil))
    @connection.stubs(:request).returns( File.open("test/response/everything.xml") )
  end
end
