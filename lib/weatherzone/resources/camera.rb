module Weatherzone
  class Camera < Weatherzone::Resource
    attribute :time
    attribute :tz
    attribute :name
    attribute :status
    attribute :filename
    attribute :thumbnail_filename
  end
end