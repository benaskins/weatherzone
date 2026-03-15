module Weatherzone
  class Lift < Weatherzone::Resource
    attribute :time
    attribute :tz
    attribute :name
    attribute :status
  end
end