module Weatherzone
  class Country < Weatherzone::Resource
    attribute :code
    attribute :name
    elements :location, :as => :locations, :class => Location
  end
end