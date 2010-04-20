require File.dirname(__FILE__) + '/support/dependencies.rb'

class Test::Unit::TestCase
  def setup
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/everything.xml") )
  end
end
