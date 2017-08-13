# frozen_string_literal: true

require "active_support/inflector/inflections"

module JustimmoClient
  ActiveSupport::Inflector.inflections do |inflect|
    inflect.acronym "XML"
    inflect.acronym "JSON"
  end
end
