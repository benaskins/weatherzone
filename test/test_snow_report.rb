require File.dirname(__FILE__) + '/test_helper.rb'

class TestSnowReport < Test::Unit::TestCase

  def setup
    super
    weather = Weather.find_by_location_code(@connection, "9770")
    country = weather.countries.first
    location = country.locations.first
    @snow_report = location.snow_reports.first
  end
  
  def test_should_be_a_snow_report
    assert_kind_of SnowReport, @snow_report
  end

  def test_should_have_many_lifts
    assert @snow_report.lifts.any?
  end

  def test_should_have_many_cameras
    assert @snow_report.cameras.any?
  end

  def test_should_not_have_nil_attributes
    [:day_name, :issue_time_local, :visibility_text, :road_conditions, :primary_surface, :snow_conditions, :snow_cover, :snow_depth_avg_cm, :snow_depth_new_cm, 
      :snow_making, :grooming, :last_snowfall_date, :resort_summary, :lifts_open].each do |attr_name|
      assert_not_nil @snow_report.send(attr_name), "@snow_report should respond to #{attr_name}"
    end
  end
end
