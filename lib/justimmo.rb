# frozen_string_literal: true

require 'justimmo/version'
require 'justimmo/errors'
require 'justimmo/config'
require 'justimmo/logger'
require 'justimmo/parser'

# The Justimmo API.
module Justimmo
  class << self
    # Loads configuration and initializes the API.
    # @see Config.configure
    # @see Logger.configure
    def configure(&block)
      Justimmo::Config.configure(&block)
      Justimmo::Logger.configure(Justimmo::Config)

      initialize_api
    end

    # Load the API with the version specified in the configuration.
    # @raise [InitializationError] If the API was not configured.
    def initialize_api
      return if initialized?
      raise InitializationError, 'Missing configuration' unless configured?
      require 'justimmo/employee'
      require 'justimmo/realty'
      @initialized = true
    end

    # Check if the API was initialized.
    # @return [true, false]
    def initialized?
      @initialized || false
    end

    # Check if the API was initialized.
    # @return [true, false]
    def configured?
      Justimmo::Config.configured?
    end
  end
end
