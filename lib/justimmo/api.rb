# frozen_string_literal: true

require "active_support/core_ext/string/inflections"
require "justimmo/config"

module Justimmo
  # Internal API
  module API
    VERSION = Justimmo::Config.api_ver || 1

    def self.versioned_autoload(path)
      autoload_path = File.join("justimmo/api", "v#{VERSION}", path)
      autoload_sym  = File.split(path).last.camelize.to_sym
      autoload autoload_sym, autoload_path
    end

    private_class_method :versioned_autoload

    %w[
      mapper query resource
      realty_query realty
      employee_query employee
      attachment area price
    ].each do |f|
      versioned_autoload(f)
    end
  end
end
