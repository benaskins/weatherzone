$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'activesupport'
require 'hpricot'
require 'digest/md5'
require 'timeout'

begin
  require 'openuri_memcached'
  # Cache for 10 minutes, the web service cache's for the same period so this ensures we've always got
  # the freshest data and the speediest responses
  OpenURI::Cache.expiry = 60 * 10
  OpenURI::Cache.enable!
rescue LoadError
  require 'open-uri'
end

require 'weatherzone/resource'

module Weatherzone
  VERSION = '0.3.0'
end

