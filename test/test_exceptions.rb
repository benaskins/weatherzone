require File.dirname(__FILE__) + '/support/dependencies.rb'

class TestExceptions < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.connect(ENV['WZ_USER'], ENV['WZ_PASS'], :url => ENV['WZ_URL'], :timeout_after => 10) do
      eval(File.open(File.dirname(__FILE__) + '/../.wzkey.rb', 'r').read)
    end
    @connection = Weatherzone::Connection.instance
  end
  
  def test_should_have_credentials
    assert ENV['WZ_USER'], "You need to set the WZ_USER environment variable to run these tests"
    assert ENV['WZ_PASS'], "You need to set the WZ_PASS environment variable to run these tests"
    assert ENV['WZ_URL'],  "You need to set the WZ_URL  environment variable to run these tests"
  end
  
  def test_should_have_keygen
    File.open(File.dirname(__FILE__) + '/../.wzkey.rb', 'r')
  rescue Exception
    assert false, "You need to create #{File.dirname(__FILE__) + '/../.wzkey.rb'} to run these tests"
  end
  
  def test_request_failed_should_capture_original_exception
    timeout(0.1) do
      sleep(1)
    end
  rescue Exception => e
    begin
      raise Weatherzone::RequestFailed.new("url", e)
    rescue Weatherzone::RequestFailed => weatherzone_exception
      assert_instance_of Timeout::Error, weatherzone_exception.original_exception
    end
  end
    
  def test_connection_should_raise_request_failed_on_timeout
    @connection.timeout_after = 0.1
    assert_raises Weatherzone::RequestFailed do
      Weather.find_by_location_name("Sydney")
    end
  end
    
end
