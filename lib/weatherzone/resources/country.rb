require 'weatherzone/resources/location'

class Country < Weatherzone::Resource
  attributes :code, :name
  elements :location, :as => :locations, :class => Location
end
