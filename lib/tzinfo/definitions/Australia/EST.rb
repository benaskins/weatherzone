require 'tzinfo/timezone_definition'

module TZInfo
  module Definitions
    module Australia
      module EST
        include TimezoneDefinition
        
        linked_timezone 'Australia/EST', 'Australia/Brisbane'
      end
    end
  end
end
