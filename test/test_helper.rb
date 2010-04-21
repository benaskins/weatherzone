require File.dirname(__FILE__) + '/support/dependencies.rb'

class Test::Unit::TestCase
  def setup
    keygen = lambda do
      eval(File.open(File.dirname(__FILE__) + '/../.wzkey.rb', 'r').read)      
    end
    @connection = Weatherzone::Connection.new(ENV['WZ_USER'], ENV['WZ_PASS'], keygen, :url => ENV['WZ_URL'], :timeout_after => 10)
    @connection.stubs(:request).returns( File.open("test/response/everything.xml") )
  end
end
