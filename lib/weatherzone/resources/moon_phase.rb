class MoonPhase < Weatherzone::Resource

  has_elements :day_name, :date, :moon_phase
  has_attribute :phase_num, :on_elements => :moon_phase
  has_attribute :phase_text, :on_elements => :moon_phase
  has_attribute :image_name, :on_elements => :moon_phase

  PHASE_TEXT_TRANSLATIONS = {
    "1st quarter" => "First quarter",
    "Full moon" => "Full moon",
    "3rd quarter" => "Last quarter",
    "New moon" => "New moon"
  }

  def date
    Date.parse(@date)
  end
  
  def phase_text
    PHASE_TEXT_TRANSLATIONS[moon_phase.phase_text]
  end
  
end