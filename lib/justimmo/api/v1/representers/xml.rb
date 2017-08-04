# frozen_string_literal: true

module Justimmo::V1
  module XML
    extend Justimmo::Utils

    autoload_dir "#{__dir__}/xml/*_representer.rb"
  end
end
