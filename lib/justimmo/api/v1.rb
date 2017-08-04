# frozen_string_literal: true

require "justimmo/autoload"

module Justimmo
  module V1
    extend Justimmo::Utils

    API_PATH = "#{__dir__}/v1"

    autoload_dir "#{API_PATH}/models/*.rb"
    autoload_dir "#{API_PATH}/representers/*.rb"
    autoload_dir "#{API_PATH}/requests/*_request.rb"
  end
end
