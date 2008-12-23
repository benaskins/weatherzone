class MoonPhase < Weatherzone::Resource

  has_elements "day_name", "date", "moon_phase"

  def self.all(options={})
    options[:params] = options[:params] || "&moon=1"
    find(:astro_element, options)
  end
  
end