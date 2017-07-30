require 'justimmo/api'

module Justimmo
  module Core
    # Logging support
    module Logging
      def logger
        Justimmo.logger
      end
    end
  end
end
