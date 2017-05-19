# frozen_string_literal: true

require 'justimmo/version'
require 'justimmo/errors'

require 'justimmo/config'
require 'justimmo/logger'
require 'justimmo/parser'

require 'justimmo/employee'
require 'justimmo/realty'

# The Justimmo API.
module Justimmo
  # Convenience method that sets configuration and initializes the logger.
  # @see Config.configure
  def self.configure(&block)
    Justimmo::Config.configure(&block)
    Justimmo::Logger.configure(Justimmo::Config)
  end
end
