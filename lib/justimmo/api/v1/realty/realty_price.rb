# frozen_string_literal: true

require 'justimmo/api/v1/resource'

module Justimmo::API
  # Holds price information like rent and purcase price.
  class RealtyPrice < Resource
    def initialize(options = {})
      @attributes = %i[
        currency purcase_price additional_costs price
      ]

      super(options)
    end
  end
end
