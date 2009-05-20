require File.dirname(__FILE__) + '/test_helper.rb'

class TestImage < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code("9770")
    country = weather.countries.first
    location = country.locations.first
    @image = location.synoptic_charts.first
  end
  
  def test_should_be_an_image
    assert_kind_of Image, @image
  end

  def test_should_not_have_nil_attributes
    [:issue_day_name, :issue_time_local, :valid_time, :text, :url].each do |attr_name|
      assert_not_nil @image.send(attr_name), "@image should respond to #{attr_name}"
    end
  end

end
