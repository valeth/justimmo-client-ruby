# frozen_string_literal: true

module JustimmoClient::V1
  # @api private
  module JSON
    extend JustimmoClient::Utils

    autoload_dir "#{__dir__}/json/*_representer.rb"
  end
end
