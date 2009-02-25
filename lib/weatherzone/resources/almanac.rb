class Almanac < Weatherzone::Resource  
  attributes :month_num, :month_name, :date_start, :date_end

  elements :almanac_period, :as => :almanac_periods, :class => AlmanacPeriod
end