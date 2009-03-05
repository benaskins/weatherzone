class Almanac < Weatherzone::Resource  
  attributes :month_num, :month_name, :date_start, :date_end

  elements :almanac_period, :as => :almanac_periods, :class => AlmanacPeriod
  
  def mtd
    @mtd ||= almanac_periods.detect { |ap| ap.code == "MTD" }
  end
  
  def ytd
    @ytd ||= almanac_periods.detect { |ap| ap.code == "YTD" }
  end
  
  def extremes
    @extremes ||= almanac_periods.detect { |ap| ap.code == "Extremes" }
  end
  
end