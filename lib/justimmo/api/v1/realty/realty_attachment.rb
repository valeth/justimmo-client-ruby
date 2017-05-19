# frozen_string_literal: true

require 'justimmo/api/v1/resource'

module Justimmo::API
  # An attachment, like images etc.
  class RealtyAttachment < Resource
    def initialize(options = {})
      @attributes = %i[]

      super(options)
    end
  end
end
