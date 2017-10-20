# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

module JustimmoClient
  # Useful utility methods
  # @api private
  module Utils
    def autoload_dir(path)
      dirname = File.dirname(path)

      Dir[path].each do |f|
        basename = File.basename(f, ".rb")
        send :autoload, basename.classify, File.join(dirname, basename)
      end
    end

    def versioned_api(*name)
      (["JustimmoClient::V#{JustimmoClient::Config.api_ver}"] + name).join("::").constantize
    end

    def api(name)
      "JustimmoClient::#{name.to_s.classify}".constantize
    end

    def representer(name, type = :xml)
      versioned_api(type.to_s.classify, "#{name.to_s.classify}Representer")
    end

    def model(name)
      versioned_api(name.to_s.classify)
    end

    def request(name)
      versioned_api("#{name.to_s.classify}Request")
    end

    def interface(name)
      versioned_api("#{name.to_s.classify}Interface")
    end

    def translate(text)
      I18n.translate("justimmo_client.#{text}", raise: true)
    rescue I18n::MissingTranslationData
      text.split(".").last.capitalize
    end
  end
end
