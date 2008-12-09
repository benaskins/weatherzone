require File.dirname(__FILE__) + '/test_helper.rb'
require 'mocha'

require 'weatherzone/resources/warning.rb'

class TestWarning < Test::Unit::TestCase

  def setup
    create_connection
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/warnings.xml") { |f| Hpricot.XML(f) } )
    @warning = Warning.find("9770").first
  end
  
  def test_should_exist
    assert @warning.is_a?(Warning)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    Warning.fields.each do |e|
      assert_not_nil @warning.send(e)
    end
  end

end
