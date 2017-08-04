# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

module Justimmo
  module Utils
    def autoload_dir(path)
      dirname = File.dirname(path)

      Dir[path].each do |f|
        basename = File.basename(f, ".rb")
        send :autoload, basename.classify, File.join(dirname, basename)
      end
    end

    def versioned_api
      "Justimmo::V#{Justimmo::Config.api_ver}"
    end

    def representer(name, type = :xml)
      "#{versioned_api}::#{type.to_s.upcase}::#{name.to_s.classify}Representer".constantize
    end

    def model(name)
      "#{versioned_api}::#{name.to_s.classify}".constantize
    end

    def request(name)
      "#{versioned_api}::#{name.to_s.classify}Request".constantize
    end
  end
end
