require 'tzinfo/timezone_definition'

module TZInfo
  module Definitions
    module Australia
      module WST
        include TimezoneDefinition
        
        linked_timezone 'Australia/WST', 'Australia/Perth'
      end
    end
  end
end
