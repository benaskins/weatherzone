class Weather < Weatherzone::Resource
  include Weatherzone::Finder
  elements :country, :as => :countries, :class => Country
  elements :astro_element, :as => :moon_phases, :class => MoonPhase
  elements :news_item, :as => :news_items, :class => NewsItem
end