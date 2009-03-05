module Weatherzone  
  module Helpers
    module DateParser
      def self.included(klass)
        klass.class_eval do

          def self.interpret_as_date(*methods)
            methods.each do |method_name|
              define_method method_name do
                Date.parse(instance_variable_get("@#{method_name}"))
              end
            end
          end

          def self.interpret_as_time(*methods)
            methods.each do |method_name|
              define_method method_name do
                Time.parse(instance_variable_get("@#{method_name}"))
              end
            end
          end
          
        end
      end
    end
  end
end