# frozen_string_literal: true

require 'active_support/core_ext/string/inflections'
require 'justimmo/config'
require 'justimmo/logger'

module Justimmo
  # Internal API
  module API
    VERSION = Justimmo::Config.api_ver || 1

    def self.versioned_autoload(path)
      autoload_path = File.join('justimmo/api', "v#{VERSION}", path)
      autoload_sym  = File.split(path).last.camelize.to_sym
      autoload autoload_sym, autoload_path
    end

    private_class_method :versioned_autoload

    %w[mapper query realty_mapper realty_query resource realty employee].each do |f|
      versioned_autoload(f)
    end

    %w[area attachment category contact geo management price].each do |f|
      versioned_autoload("realty/realty_#{f}")
    end
  end
end
