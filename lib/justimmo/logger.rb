# frozen_string_literal: true

require 'logger'

module Justimmo
  # The Justimmo logger.
  class Logger < Logger
    @logger = nil

    # The main logger.
    #
    # @param config [Config]
    #   Logger configuration, must at least define a _debug?_ method.
    def initialize(config = nil)
      super(STDOUT)

      self.level = config&.debug? ? Logger::DEBUG : Logger::INFO
      self.formatter = proc do |severity, datetime, _progname, msg|
        "#{severity}  [#{datetime}]  #{msg}\n"
      end
    end

    class << self
      # Configure the global logger.
      #
      # @param (see #initialize)
      # @return [Logger] The global logger instance.
      def configure(config = nil)
        @logger = new(config)
      end

      def debug(*args) # :nodoc:
        @logger&.debug(*args)
      end

      def info(*args) # :nodoc
        @logger&.info(*args)
      end

      def warn(*args) # :nodoc:
        @logger&.warn(*args)
      end

      def error(*args) # :nodoc:
        @logger&.error(*args)
      end
    end
  end
end
