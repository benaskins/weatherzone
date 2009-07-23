$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'digest/md5'
require 'timeout'

require 'nokogiri'
require 'sax-machine'
require 'tzinfo'

begin
  $LOAD_PATH << File.join(File.dirname(__FILE__), *%w[vendor openuri_memcached lib])
  if defined? Rails
    require 'openuri/rails-cache'
  else
    require 'openuri/memcached'
    # Cache for 10 minutes. The web service caches for the same period, so this ensures we've always got
    # the freshest data and the speediest response.
    OpenURI::Cache.expiry = 600
  end
rescue LoadError
  require 'open-uri'
end

unless defined?(ActiveSupport)
  require 'ext/class'
  require 'ext/object'
end

require 'weatherzone/finder'
require 'weatherzone/resource'
require 'weatherzone/helpers/almanac_element'
require 'weatherzone/helpers/date_parser'
require 'weatherzone/helpers/units'

module Weatherzone
  VERSION = '0.5.4'
end