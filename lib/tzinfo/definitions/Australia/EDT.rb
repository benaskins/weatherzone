require 'tzinfo/timezone_definition'

module TZInfo
  module Definitions
    module Australia
      module EDT
        include TimezoneDefinition
        
        linked_timezone 'Australia/EDT', 'Australia/Sydney'
      end
    end
  end
end
