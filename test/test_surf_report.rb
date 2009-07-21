require File.dirname(__FILE__) + '/test_helper.rb'

class TestSurfReport < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code("9770")
    country = weather.countries.first
    location = country.locations.first
    @surf_report = location.surf_reports.first
  end
  
  def test_should_be_a_surf_report
    assert_kind_of SurfReport, @surf_report
  end

  def test_should_not_have_nil_attributes
    [:issue_day_name, :issue_time_local, :report_day_name, :report_time_local, :image_url, :surf_summary_text, :wind_text, :weather_text, :summary].each do |attr_name|
      assert_not_nil @surf_report.send(attr_name), "@surf_report should respond to #{attr_name}"
    end
  end
end
