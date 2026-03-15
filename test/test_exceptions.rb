require File.dirname(__FILE__) + '/test_helper.rb'

class TestExceptions < Test::Unit::TestCase  
  def setup
    keygen = Proc.new { 12345 }
    @connection = Weatherzone::Connection.new("username", "password", :timeout_after => 10, :keygen => keygen, :logger => Logger.new(nil))
  end
  
  def test_request_failed_should_capture_original_exception
    original = Timeout::Error.new
    exception = Weatherzone::RequestFailed.new("url", original)
    assert_instance_of Timeout::Error, exception.original_exception
  end
    
  def test_connection_should_raise_request_failed_on_timeout
    mock_uri = mock()
    mock_uri.expects(:read).raises(Timeout::Error)
    URI.stubs(:parse).returns(mock_uri)
    
    assert_raises Weatherzone::RequestFailed do
      Weatherzone::Weather.find_by_location_name(@connection, "Sydney")
    end
  end
    
end
