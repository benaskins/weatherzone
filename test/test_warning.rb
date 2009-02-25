require File.dirname(__FILE__) + '/test_helper.rb'

class TestWarning < Test::Unit::TestCase

  def setup
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/warnings.xml") )
    weather = Weather.find_by_location_code("9770")
    country = weather.countries.first
    location = country.locations.first
    @warning = location.warnings.first
  end
  
  def test_should_be_a_warning
    assert_kind_of Warning, @warning
  end

  def test_should_not_have_nil_attributes
    [:id, :type, :issue_day_name, :issue_time_local, :expire_time_local, :short_text, :url].each do |attr_name|
      assert_not_nil @warning.send(attr_name), "@warning should respond to #{attr_name}"
    end
  end

end
