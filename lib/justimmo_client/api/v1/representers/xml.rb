# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    extend JustimmoClient::Utils

    autoload_dir "#{__dir__}/xml/*_representer.rb"
  end
end
