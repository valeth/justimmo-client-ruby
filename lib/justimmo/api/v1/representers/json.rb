# frozen_string_literal: true

module Justimmo::V1
  module JSON
    extend Justimmo::Utils

    autoload_dir "#{__dir__}/json/*_representer.rb"
  end
end
