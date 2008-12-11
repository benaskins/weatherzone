require File.dirname(__FILE__) + '/test_helper.rb'

require 'weatherzone/resources/image.rb'

class TestImage < Test::Unit::TestCase

  def setup
    create_connection
    @image = Image.find("9770", :type => "syn", :size => "640x480", :days => 0).first
  end
  
  def test_should_exist
    assert @image.is_a?(Image)
  end
  
  def test_should_receive_each_specified_field_and_return_non_nil_values
    Image.fields.each do |e|
      assert_not_nil @image.send(e)
    end
  end

  def test_should_raise_exception_on_invalid_field_name
    assert_raises Weatherzone::DataElementNotAvailable do
      @image.nonsense_field
    end
  end

end
