class MoonPhase < Weatherzone::Resource

  has_elements "day_name", "date", "moon_phase"

  PHASE_TEXT_TRANSLATIONS = {
    "1st quarter" => "First quarter",
    "Full moon" => "Full moon",
    "3rd quarter" => "Last quarter",
    "New moon" => "New moon"
  }

  def self.all(options={})
    options[:params] = options[:params] || "&moon=1"
    find(:astro_element, options)
  end
  
  def date
    Date.parse(@fields["date"].value)
  end
  
  def phase_text
    PHASE_TEXT_TRANSLATIONS[moon_phase.phase_text]
  end
  
end