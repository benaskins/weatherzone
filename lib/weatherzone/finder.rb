module Weatherzone
  module Finder

    INCLUDES_MAP = {
      :forecasts => "fc=1",
      :point_forecasts => "fc=3",
      :district_forecasts => "dist_fc=1",
      :conditions => "obs=1",
      :warnings => "warn=2",
      :state_forecasts => "state_fc=1",
      :uv_index => "uv=1",
      :sun => "fc_sun=2",
      :moon => "fc_moon=1",
      :historical_observations => "histobs=1",
      :daily_observations => "dlyobs=7",
      :position => "latlon=1",
      :moon_phases => "moon=1",
      :news_items => "news=2",
      :almanac => "almanac=1",
      :links => "links=1",
      :radar_animator => "ra=1",
      :radar_still => "rs=1",
      :satellite_animator => "sa=1",
      :satellite_still => "ss=1",
      :marine_forecast => "marine=1",
      :tides => "tides=4",
      :tide_height => "tideh=1",
      :surf_report => "surf_rpt=2",
      :climate_periods => "climate=1(months=12)",
      :related_locations => "locdet=1",
      :buoy_observations => "buoy=1(period=24)"
    } 

    def self.included(klass)
      klass.class_eval do
        @@connection = Weatherzone::Connection.instance

        class << self
          def parse_file(file_name)
            parse(File.open(file_name))
          end
          
          def find(options, location_code=nil)
            set_options(options)
            make_request(build_params(location_code, options))
          end
          
          def find_by_location_code(location_code, options={})
            options = options.dup
            find(options, location_code)
          end
          
          def find_by_twcid(twcid, options={})
            options = options.dup
            options.merge!(:params => "&lt=twcid&lc=#{twcid}")
            find(options)
          end

          def find_by_location_name(location_name, options={})
            options = options.dup
            location_name = location_name.gsub(" ", "%20").gsub("-", "%20")
            options.merge!(:params => "&lt=aploc&ln=#{location_name}")
            find(options)
          end

          def find_by_swellnet_code(swellnet_code, options={})
            options = options.dup
            options.merge!(:params => "&lt=swellnet&lc=#{swellnet_code}")
            find(options)
          end

          def find_by_location_filter(filter, options={})
            options = options.dup
            options.merge!(:params => "&lt=twcid&lf=#{filter}")
            find(options)
          end
          
          def find_by_district(district_code, options={})
            options = options.dup
            options.merge!(:params => "&lt=twcid&dist=#{district_code}")
            find(options)            
          end

          def find_districts_by_state(state, options={})
            options = options.dup
            options.merge!(:params => "&lt=dist&state=#{state}")
            find(options).countries.first.locations
          end

          def find_radars_by_state(state, options={})
            options = options.dup
            options.merge!(:params => "&lt=radar&links=1&ra=1&state=#{state}")
            find(options).countries.first.locations
          end

          def build_params(location_code, options)
            params = location_code ? "&lc=#{location_code}" : ""
            params  += options.delete(:params)                  if options[:params]
            params  += include_params(options.delete(:include)) if options[:include]
            params  += include_image(options.delete(:image))    if options[:image]
            params  += parse_params(options) unless options.empty?
            params
          end

          protected
          def set_options(options)
            @@connection.settings.weather_class ||= self
            self.temperature_unit = options.delete(:temperature_unit)
          end

          def make_request(params)
            response = @@connection.request(params)
            parse(response)
          end
          
          def include_params(includes)
            includes.inject("") do |params, relationship|
              if param = INCLUDES_MAP[relationship]
                params += "&#{param}"
              else
                params
              end
            end
          end
  
          def include_image(image)
            "&images=#{image[:type]}(days=#{image[:days]};size=#{image[:size]})"   
          end

          def parse_params(options)
            options.inject("") do |params, (key, value)|
              params += "&#{key}=#{value}"
            end      
          end
        end
      end
    end
  end
end