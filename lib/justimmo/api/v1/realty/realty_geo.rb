# frozen_string_literal: true

require 'justimmo/api/v1/resource'

module Justimmo::API
  # Holds geographic information.
  class RealtyGeo < Resource
    def initialize(options = {})
      @attributes = %i[
        zip_code location country federal_state user_defined_simplefield
      ]

      super(options)
    end
  end
end
