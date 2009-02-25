module Weatherzone  
  module Helpers
    module AlmanacElement

      def self.included(klass)
        klass.class_eval do
          def self.almanac_element(type, subtype, options={})
            period      = options[:period]
            method_name = options[:as]
            attributes  = options[:with_attributes]

            method_name = "#{subtype.downcase.gsub(' ', '_')}_#{type.downcase.gsub(' ', '_')}" unless method_name
    
            with_options = {:type => type, :subtype => subtype}
            with_options.merge!(:period => period) if period
    
            element :almanac_element, :with => with_options, :as => method_name
    
            attributes.each do |attr_name|
              element :almanac_element, :value => attr_name, :with => with_options, :as => "#{method_name}_#{attr_name}"
            end
          end
        end
      end

    end
  end
end