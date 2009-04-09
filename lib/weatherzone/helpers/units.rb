module Weatherzone  
  module Helpers
    module Units

      def self.included(klass)
        klass.class_eval do
          def self.value_plus_unit_readers(*methods)
            methods.each do |method_name|
              define_method method_name do
                "#{send(method_name.to_s + '_value')}#{send(method_name.to_s + '_units')}"
              end
            end
          end
        end
      end

    end
  end
end