require File.dirname(__FILE__) + '/test_helper.rb'

class TestDateParser < Test::Unit::TestCase

  class SomeResource < Weatherzone::Resource
    include Weatherzone::Helpers::DateParser
    attr_writer :created_at, :issue_time_local
    interpret_as_date :created_at
    interpret_as_time :issue_time_local
    
    def issue_time_local_tz
      "EST"
    end
  end
  
  def test_parses_date
    resource = SomeResource.new
    resource.created_at = "12/04/1972"
    assert_equal Date.parse("12/04/1972"), resource.created_at
  end
  
  def test_doesnt_raise_on_nil_dates
    resource = SomeResource.new
    resource.created_at = nil
    assert_equal nil, resource.created_at
  end
  
  def test_parses_time
    time = "2009-08-12T09:17:00"
    
    tz = TZInfo::Timezone.get("Australia/EST")
    expected_utc = tz.local_to_utc(Time.parse(time))
    
    resource = SomeResource.new
    resource.issue_time_local = time

    assert_equal expected_utc, resource.issue_time_local_utc
    assert_equal tz.utc_to_local(expected_utc), resource.issue_time_local    
  end
  
  def test_doesnt_raise_on_nil_times
    resource = SomeResource.new
    resource.issue_time_local = nil
    assert_equal nil, resource.issue_time_local_utc
    assert_equal nil, resource.issue_time_local
  end

end
