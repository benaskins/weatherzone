class TestConnection < Test::Unit::TestCase

  def test_should_connect
    assert create_connection  
  end

end