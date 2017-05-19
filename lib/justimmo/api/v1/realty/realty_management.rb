# frozen_string_literal: true

require 'justimmo/api/v1/resource'

module Justimmo::API
  # Holds management related information like realty status.
  class RealtyManagement < Resource
    def initialize(options = {})
      @attributes = %i[
        show_realty_address status status_id
        user_defined_simplefield
      ]

      super(options)
    end
  end
end
