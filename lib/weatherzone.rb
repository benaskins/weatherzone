$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'
require 'digest/md5'
require 'timeout'

require 'nokogiri'
require 'sax-machine'
require 'tzinfo'
require 'net/http/persistent'

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
  VERSION = '0.8.2'
end