$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'digest/md5'
require 'timeout'

require 'nokogiri'
require 'sax-machine'

begin
  require 'openuri/memcached'
  # Cache for 10 minutes. The web service caches for the same period, so this ensures we've always got
  # the freshest data and the speediest response.
  OpenURI::Cache.expiry = 60 * 10
  OpenURI::Cache.enable!
rescue LoadError
  require 'open-uri'
end

require 'ext/class'
require 'weatherzone/finder'
require 'weatherzone/resource'
require 'weatherzone/helpers/almanac_element'

module Weatherzone
  VERSION = '0.4.0'
end

