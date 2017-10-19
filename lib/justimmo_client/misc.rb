# frozen_string_literal: true

require "active_support/inflector/inflections"
require "active_support/i18n"

ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym "XML"
  inflect.acronym "JSON"
end

I18n.load_path += Dir[File.expand_path("../../locales/*.yml", __dir__)]
I18n.default_locale = :en
