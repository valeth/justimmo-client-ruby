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

    def translate(text)
      I18n.translate("justimmo_client.#{text}", raise: true)
    rescue I18n::MissingTranslationData
      text.split(".").last.titleize
    end
  end
end
