# frozen_string_literal: true

require 'logger'

module Justimmo
  # The Justimmo logger.
  class Logger < Logger
    @logger = nil

    def initialize(config)
      super(STDOUT)

      self.level = config.debug? ? Logger::DEBUG : Logger::INFO
      self.formatter = proc do |severity, datetime, _progname, msg|
        "#{severity}  [#{datetime}]  #{msg}\n"
      end
    end

    class << self
      def configure(config)
        @logger = new(config)
      end

      def debug(*args)
        @logger&.debug(*args)
      end

      def info(*args)
        @logger&.info(*args)
      end

      def warn(*args)
        @logger&.warn(*args)
      end

      def error(*args)
        @logger&.error(*args)
      end
    end
  end
end
