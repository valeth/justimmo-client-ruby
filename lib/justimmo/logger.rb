# frozen_string_literal: true

require 'logger'
require 'justimmo/config'

module Justimmo
  # The Justimmo logger.
  class Logger < Logger
    # The main logger.
    # @param config [Config]
    #   Logger configuration, must at least define a _debug?_ method.
    def initialize(config = Justimmo::Config)
      super(STDOUT)

      self.level = config&.debug? ? Logger::DEBUG : Logger::INFO
      self.formatter = proc do |severity, datetime, _progname, msg|
        "#{severity}  [#{datetime}]  #{msg}\n"
      end
    end

    class << self
      def create(config = Justimmo::Config)
        @logger ||= new(config)
      end

      def debug(*msg)
        @logger&.debug(*msg)
      end

      def info(*msg)
        @logger&.info(*msg)
      end

      def warn(*msg)
        @logger&.warn(*msg)
      end

      def error(*msg)
        @logger&.error(*msg)
      end
    end
  end
end
