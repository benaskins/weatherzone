# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "weatherzone/version"

Gem::Specification.new do |s|
  s.name        = "weatherzone"
  s.version     = Weatherzone::VERSION
  s.authors     = ["Ben Askins"]
  s.email       = ["ben.askins@gmail.com"]
  s.homepage    = "http://www.weatherzone.com.au"
  s.summary     = %q{Abstracts the API calls to the WeatherZone web service}

  s.rubyforge_project = "weatherzone"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency("rake")
  s.add_development_dependency("mocha")
  s.add_development_dependency("timecop")
  
  s.add_dependency("nokogiri", "~> 1.5")
  s.add_dependency("sax-machine", "~> 0.1.0")
  s.add_dependency("tzinfo", "~> 0.3")
  s.add_dependency("activesupport", "~> 3.1")
  s.add_dependency("i18n")
end
