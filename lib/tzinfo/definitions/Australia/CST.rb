require 'tzinfo/timezone_definition'

module TZInfo
  module Definitions
    module Australia
      module CST
        include TimezoneDefinition
        
        linked_timezone 'Australia/CST', 'Australia/Darwin'
      end
    end
  end
end
