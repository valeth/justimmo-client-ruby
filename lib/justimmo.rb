# frozen_string_literal: true

require "justimmo/autoload"

# The Justimmo API.
module Justimmo
  module_function

  # Loads configuration and initializes the API.
  def configure(&block)
    Justimmo::Config.configure(&block)
    initialize_api
  end

  def initialize_api
    api_ver = Justimmo::Config.api_ver
    send :autoload, "V#{api_ver}", "justimmo/api/v#{api_ver}"
  end

  # Initially load the defaul API scope.
  initialize_api
end
