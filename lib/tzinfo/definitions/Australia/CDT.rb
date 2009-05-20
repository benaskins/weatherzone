require 'tzinfo/timezone_definition'

module TZInfo
  module Definitions
    module Australia
      module CDT
        include TimezoneDefinition
        
        linked_timezone 'Australia/CDT', 'Australia/Adelaide'
      end
    end
  end
end
