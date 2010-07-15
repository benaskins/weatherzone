require 'weatherzone/resources/country'
require 'weatherzone/resources/moon_phase'
require 'weatherzone/resources/news_item'

class Weather < Weatherzone::Resource
  include Weatherzone::Finder
  elements :country, :as => :countries, :class => Country
  elements :astro_element, :as => :moon_phases, :class => MoonPhase
  elements :news_item, :as => :news_items, :class => NewsItem

  def first_location
    countries.first.locations.first
  end
  
  def has_locations?
    countries.any? && countries.first.locations.any?
  end
end
