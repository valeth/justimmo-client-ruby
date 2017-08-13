# frozen_string_literal: true

require "justimmo_client/autoload"

# The Justimmo API.
module JustimmoClient
  module_function

  # Loads configuration and initializes the API.
  def configure(&block)
    JustimmoClient::Config.configure(&block)
    initialize_api
  end

  def initialize_api
    api_ver = JustimmoClient::Config.api_ver
    send :autoload, "V#{api_ver}", "justimmo_client/api/v#{api_ver}"
  end

  # Initially load the defaul API scope.
  initialize_api
end
