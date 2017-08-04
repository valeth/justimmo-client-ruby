# frozen_string_literal: true

require "active_support/inflector/inflections"

module Justimmo
  ActiveSupport::Inflector.inflections do |inflect|
    inflect.acronym "XML"
    inflect.acronym "JSON"
  end
end
