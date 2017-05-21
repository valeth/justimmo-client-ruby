# frozen_string_literal: true

require 'justimmo/api/v1/resource'

module Justimmo::API
  # Holds geographic information.
  class RealtyGeo < Resource
    def initialize(options = {})
      @attributes = %i[
        zip_code location country federal_state latitude longitude
      ]

      coordinates(options) if options.key?(:user_defined_simplefield)
      iso_country(options)

      super(options)
    end

    private

    def coordinates(options)
      %i[latitude longitude].each do |l|
        val = options[:user_defined_simplefield].select do |x|
          x[:@field_name] == "#{l}_precise".to_sym
        end

        options[l] = val.dig(0, :value)
      end

      options.delete(:user_defined_simplefield)
    end

    def iso_country(options)
      options[:country] = options.dig(:country, :@iso_country) || options[:country]
    end
  end
end
