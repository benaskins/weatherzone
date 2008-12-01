class TestConnection < Test::Unit::TestCase

  def test_should_connect
    create_connection
    # TODO: replace woefully inadequate test
    assert @connection  
  end

end