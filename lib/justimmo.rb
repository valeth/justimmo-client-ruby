# frozen_string_literal: true

require 'justimmo/version'
require 'justimmo/errors'
# require 'justimmo/config'
# require 'justimmo/parser'

require 'logger'

# The Justimmo API.
module Justimmo
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

    def rails_logger
      ::Rails&.logger if ENV.fetch('JUSTIMMO_USE_RAILS_LOGGER', true) && defined?(::Rails)
    end

    # Loads configuration and initializes the API.
    # @see Config.configure
    def configure(&block)
    #   Justimmo::Config.configure(&block)
    #
    #   initialize_api
    end

    # def initialize_api
    #   return if initialized?
    #   raise InitializationError, 'Missing configuration' unless configured?
    #   require 'justimmo/employee'
    #   require 'justimmo/realty'
    #   @initialized = true
    # end

    # Check if the API was initialized.
    # @return [true, false]
    # def initialized?
    #   @initialized || false
    # end

    # Check if the API was initialized.
    # @return [true, false]
    # def configured?
    #   Justimmo::Config.configured?
    # end
  end
end
