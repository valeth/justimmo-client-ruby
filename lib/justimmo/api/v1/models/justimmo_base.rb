# frozen_string_literal: true

require "virtus"

module Justimmo::V1
  class JustimmoBase
    include Justimmo::Logging
    include Virtus.model do |mod|
      mod.coercer.config.string.boolean_map = { "0" => false, "1" => true }
    end
  end
end
