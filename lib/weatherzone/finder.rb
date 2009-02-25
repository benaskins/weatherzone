module Weatherzone
  module Finder

    INCLUDES_MAP = {
      :forecasts => "fc=1",
      :point_forecasts => "fc=3",
      :district_forecasts => "dist_fc=1",
      :conditions => "obs=1",
      :warnings => "warn=1",
      :state_forecasts => "state_fc=1",
      :uv_index => "uv=1",
      :sun => "fc_sun=2",
      :moon => "fc_moon=1",
      :historical_observations => "histobs=1",
      :daily_observations => "dlyobs=7",
      :position => "latlon=1",
      :moon_phases => "moon=1",
      :news_items => "news=1"
    } 

    def self.included(klass)
      klass.class_eval do
        @@connection = Weatherzone::Connection.instance

        class << self
          def find(options)
            make_request(build_params(nil, options))
          end
          
          def find_by_location_code(location_code, options={})
            make_request(build_params(location_code, options))
          end

          def find_by_location_name(location_name, options={})
            location_name = location_name.gsub(" ", "%20").gsub("-", "%20")
            options.merge!(:params => "&lt=aploc&ln=#{location_name}")
            find(options)
          end

          def find_by_location_filter(filter, options={})
            options.merge!(:params => "&lt=twcid&lf=#{filter}")
            find(options)
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
          def make_request(params)
            response = @@connection.request(params)
            parse(response)
          rescue Weatherzone::RequestFailed => e
            @@connection.error(e.message)                        
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