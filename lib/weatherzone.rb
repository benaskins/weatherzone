$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'activesupport'
require 'open-uri'
require 'hpricot'
require 'digest/md5'

require 'weatherzone/resource'

module Weatherzone
  VERSION = '0.0.2'
end