require 'rubygems'
require 'bundler'
Bundler.setup

require 'exemplor'

require 'pp'
require 'pathname'

$LOAD_PATH << Pathname("~/Dropbox/dev/ruby/http_vanilli/lib").expand_path
require 'http_vanilli'

HttpVanilli.disallow_net_connect!
HttpVanilli.override_net_http!


Root = Pathname('../..').expand_path(__FILE__)
$LOAD_PATH << Root+'lib'

require 'weatherzone'

eg.helpers do
  def response(name)
    Root+'test/response'+"#{name}.xml"
  end
  def respond_with(name)
    [ 200, {}, [ response(name).read ] ]
  end
end
