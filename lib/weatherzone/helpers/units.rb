require 'bigdecimal'

module Weatherzone  
  module Helpers
    module Units
      def self.included(klass)
        klass.class_eval do
          
          self.temperature_attributes = []
          
          def self.temperature(*methods)
            self.temperature_attributes = methods
            value_plus_unit_readers *methods
          end
          
          def self.value_plus_unit_readers(*methods)
            methods.each do |method_name|
              define_method method_name do
                value = send("#{method_name}_value")
                if settings.strip_scale_from_units
                  value ? "#{value}#{instance_variable_get("@#{method_name}_units")}".gsub("C", "") : nil
                else
                  value ? "#{value}#{instance_variable_get("@#{method_name}_units")}".gsub("C", Weather.temperature_unit || "C") : nil
                end
              end
              
              define_method "#{method_name}_value" do
                ivar_name = instance_variable_names.include?("@#{method_name}_value") ? "@#{method_name}_value" : "@#{method_name}"
                value     = instance_variable_get(ivar_name)
                fahrenheit_conversion_required?(method_name) ? to_fahrenheit(value) : value
              end
              
              define_method "#{method_name}_units" do
                ivar_name = "@#{method_name}_units"
                unit      = instance_variable_get(ivar_name)
                fahrenheit_conversion_required?(method_name) ? unit.gsub("C", Weather.temperature_unit) : unit
              end
            end
          end

          def fahrenheit_conversion_required?(method_name)
            Weather.temperature_unit == "F" && self.class.temperature_attributes.include?(method_name)
          end

          def to_fahrenheit(value)
            ((BigDecimal(value) * BigDecimal("1.8")) + BigDecimal("32")).to_s("F")
          end
        end
      end
    end
  end
end