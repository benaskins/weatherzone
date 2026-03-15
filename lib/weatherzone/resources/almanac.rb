module Weatherzone
  class Almanac < Weatherzone::Resource  
    attribute :month_num
    attribute :month_name
    attribute :date_start
    attribute :date_end

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
end