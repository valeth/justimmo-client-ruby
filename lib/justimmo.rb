# frozen_string_literal: true

require 'justimmo/version'
require 'justimmo/errors'
require 'justimmo/core/logging'
require 'justimmo/core/config'
require 'justimmo/core/caching'

# The Justimmo API.
module Justimmo
    # Loads configuration and initializes the API.
    def self.configure(&block)
      Justimmo::Config.configure(&block)
    end
end
