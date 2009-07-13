require 'bigdecimal'

module Weatherzone  
  module Helpers
    module Units
      def self.included(klass)
        klass.class_eval do
          
          def self.value_plus_unit_readers(*methods)
            methods.each do |method_name|
              define_method method_name do
                # ivar_name = instance_variable_names.include?("@#{method_name}_value") ? "@#{method_name}_value" : "@#{method_name}"
                # value = instance_variable_get(ivar_name)
                value = send("#{method_name}_value")
                if settings.strip_scale_from_units
                  value ? "#{value}#{instance_variable_get("@#{method_name}_units")}".gsub("F", "").gsub("C", "") : nil
                else
                  value ? "#{value}#{instance_variable_get("@#{method_name}_units")}".gsub("C", Weather.temperature_unit || "C") : nil
                end
              end
              
              define_method "#{method_name}_value" do
                ivar_name = instance_variable_names.include?("@#{method_name}_value") ? "@#{method_name}_value" : "@#{method_name}"
                value = instance_variable_get(ivar_name)
                if Weather.temperature_unit == "F"
                  ((BigDecimal(value) * BigDecimal("1.8")) + BigDecimal("32")).to_s("F")
                else
                  value
                end
              end
            end
          end

        end
      end
    end
  end
end