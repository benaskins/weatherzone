class Warning < Weatherzone::Resource

  include Weatherzone::Helpers::DateParser
  
  attributes :id, :type
  has_elements :issue_day_name, :issue_time_local, :expire_time_local, :short_text, :long_text, :url

  interpret_as_time :issue_time_local, :expire_time_local
  
  # Override id and type
  attr_reader :id, :type
  
  def hash
    id.hash
  end
  
  def eql?(other)
    self.id == other.id
  end
  
end