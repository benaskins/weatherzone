require File.dirname(__FILE__) + '/test_helper.rb'

class TestDateParser < Test::Unit::TestCase

  class SomeResource
    include Weatherzone::Helpers::DateParser
    attr_writer :created_at
    interpret_as_date :created_at
  end
  
  def test_parses_date
    resource = SomeResource.new
    resource.created_at = "12/04/1972"
    assert_equal Date.parse("12/04/1972"), resource.created_at
  end
  
  def test_doesnt_bork_on_nils
    resource = SomeResource.new
    resource.created_at = nil
    assert_equal nil, resource.created_at
  end

end
