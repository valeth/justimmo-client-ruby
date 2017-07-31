# frozen_string_literal: true

require 'logger'

module Justimmo
  # Logging support
  module Logging
    class << self
      # Use the Rails or default logger if none is set.
      # @!attribute [rw] logger
      # @return [Logger]
      def logger
        @logger ||= rails_logger || default_logger
      end

      attr_writer :logger

      def default_logger
        logger = Logger.new($stdout)
        logger.level = Logger::INFO
        logger
      end

      # The Ruby on Rails logger
      # @return [Logger, nil] The logger object
      def rails_logger
        if ('true' == ENV.fetch('JUSTIMMO_USE_RAILS_LOGGER', 'true')) && defined?(::Rails)
          ::Rails&.logger
        end
      end
    end

    def logger
      Logging.logger
    end
  end
end
