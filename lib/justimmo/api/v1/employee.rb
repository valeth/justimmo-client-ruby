# frozen_string_literal: true

require 'justimmo/api/v1/resource'

module Justimmo::API
  # Holds employee contact information.
  class Employee < Resource
    def initialize(options = {})
      @attributes = %i[
        id email phone last_name first_name title salutation company street
        zip_code location feedback url personal_number image
        user_defined_anyfield
      ]

      super(options)
    end
  end
end
