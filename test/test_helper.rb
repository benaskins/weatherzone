require 'test/unit'
require 'rubygems'
require 'mocha'
require 'logger'
require 'ruby-debug'

require File.dirname(__FILE__) + '/../lib/weatherzone'

require 'weatherzone/resources/point_forecast'
require 'weatherzone/resources/forecast'
require 'weatherzone/resources/conditions'
require 'weatherzone/resources/district_forecast'
require 'weatherzone/resources/state_forecast'
require 'weatherzone/resources/historical_observation'
require 'weatherzone/resources/daily_observation'
require 'weatherzone/resources/warning'
require 'weatherzone/resources/image'
require 'weatherzone/resources/almanac_period'
require 'weatherzone/resources/almanac'
require 'weatherzone/resources/location'
require 'weatherzone/resources/country'
require 'weatherzone/resources/moon_phase'
require 'weatherzone/resources/news_item'
require 'weatherzone/resources/weather'

class Test::Unit::TestCase
  def setup
    Weatherzone::Connection.instance.stubs(:request).returns( File.open("test/response/everything.xml") )
  end
end
