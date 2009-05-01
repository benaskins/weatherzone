class AlmanacPeriod < Weatherzone::Resource  

  attributes :code, :title, :month_name, :from, :to

  include Weatherzone::Helpers::AlmanacElement
  include Weatherzone::Helpers::DateParser
  include Weatherzone::Helpers::Units
  
  # Rainfall this month
  almanac_element "Rainfall", "average", :with_attributes => [:value, :units, :days], :period => "long term", :as => :avg_rainfall_this_month
  almanac_element "Rainfall", "driest",  :with_attributes => [:value, :units, :date], :period => "this month", :as => :driest_rainfall_this_month
  almanac_element "Rainfall", "wettest", :with_attributes => [:value, :units, :date], :period => "this month", :as => :wettest_rainfall_this_month
  almanac_element "Rainfall", "so far",  :with_attributes => [:value, :units, :days, :from, :to], :period => "this month", :as => :rainfall_this_month
  almanac_element "Rainfall", "so far",  :with_attributes => [:value, :units, :days, :from, :to], :period => "this time last year", :as => :rainfall_this_time_last_year
  
  # Rainfall this year
  almanac_element "Rainfall", "average", :with_attributes => [:value, :units, :days], :period => "to the end of this month", :as => :avg_rainfall_this_year
  almanac_element "Rainfall", "driest",  :with_attributes => [:value, :units, :date], :period => "this year", :as => :driest_rainfall_this_year
  almanac_element "Rainfall", "wettest", :with_attributes => [:value, :units, :date], :period => "this year", :as => :wettest_rainfall_this_year
  almanac_element "Rainfall", "so far",  :with_attributes => [:value, :units, :days, :from, :to], :period => "this year", :as => :rainfall_this_year
  
  # Temperature this month
  almanac_element "Temperature", "average max", :with_attributes => [:value, :units], :period => "long term", :as => :avg_max_temp_long_term
  almanac_element "Temperature", "average min", :with_attributes => [:value, :units], :period => "long term", :as => :avg_min_temp_long_term
  almanac_element "Temperature", "average max", :with_attributes => [:value, :units, :from, :to], :period => "this month", :as => :avg_max_temp_this_month
  almanac_element "Temperature", "average min", :with_attributes => [:value, :units, :from, :to], :period => "this month", :as => :avg_min_temp_this_month
  almanac_element "Temperature", "hottest",     :with_attributes => [:value, :units, :date], :period => "this month", :as => :hottest_temp_this_month
  almanac_element "Temperature", "coldest",     :with_attributes => [:value, :units, :date], :period => "this month", :as => :coldest_temp_this_month
  
  # Temperature this year
  almanac_element "Temperature", "hottest",     :with_attributes => [:value, :units, :date], :period => "this year", :as => :hottest_temp_this_year
  almanac_element "Temperature", "coldest",     :with_attributes => [:value, :units, :date], :period => "this year", :as => :coldest_temp_this_year
  
  # Extremes
  almanac_element "Extreme", "coldest", :with_attributes => [:period, :year, :value, :units], :as => :coldest_extreme
  almanac_element "Extreme", "hottest", :with_attributes => [:period, :year, :value, :units], :as => :hottest_extreme
  almanac_element "Extreme", "wettest", :with_attributes => [:period, :year, :value, :units], :as => :wettest_extreme
  almanac_element "Extreme", "highest", :with_attributes => [:period, :date, :value, :units], :as => :highest_extreme_temp
  almanac_element "Extreme", "lowest",  :with_attributes => [:period, :date, :value, :units], :as => :lowest_extreme_temp
  
  interpret_as_date :driest_rainfall_this_month_date, :wettest_rainfall_this_month_date, :driest_rainfall_this_year_date, :wettest_rainfall_this_year_date,
    :hottest_temp_this_month_date, :coldest_temp_this_month_date, :hottest_temp_this_year_date, :coldest_temp_this_year_date, :highest_extreme_temp_date,
    :lowest_extreme_temp_date
  
  value_plus_unit_readers :avg_rainfall_this_month, :driest_rainfall_this_month, :wettest_rainfall_this_month, :rainfall_this_month, :rainfall_this_time_last_year,
    :avg_rainfall_this_year, :driest_rainfall_this_year, :wettest_rainfall_this_year, :rainfall_this_year, :avg_max_temp_long_term, :avg_min_temp_long_term, 
    :avg_max_temp_this_month, :avg_min_temp_this_month, :hottest_temp_this_month, :coldest_temp_this_month, :hottest_temp_this_year, :coldest_temp_this_year, 
    :coldest_extreme, :hottest_extreme, :wettest_extreme, :highest_extreme_temp, :lowest_extreme_temp
  
end