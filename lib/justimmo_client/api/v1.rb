# frozen_string_literal: true

require "justimmo_client/autoload"

module JustimmoClient
  # Version 1 of the API
  module V1
    extend JustimmoClient::Utils

    API_PATH = "#{__dir__}/v1"

    autoload_dir "#{API_PATH}/models/*.rb"
    autoload_dir "#{API_PATH}/representers/*.rb"
    autoload_dir "#{API_PATH}/requests/*_request.rb"
  end
end
