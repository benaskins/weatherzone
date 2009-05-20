require 'tzinfo/timezone_definition'

module TZInfo
  module Definitions
    module Australia
      module WDT
        include TimezoneDefinition
        
        linked_timezone 'Australia/WDT', 'Australia/Perth'
      end
    end
  end
end
