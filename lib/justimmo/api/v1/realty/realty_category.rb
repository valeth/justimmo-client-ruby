# frozen_string_literal: true

require 'active_support/core_ext/hash/keys'
require 'active_support/core_ext/hash/transform_values'
require 'justimmo/api/v1/resource'

module Justimmo::API
  # Holds category information.
  class RealtyCategory < Resource
    def initialize(options = {})
      @attributes = %i[
        usage marketing_type
        user_defined_simplefield user_defined_anyfield
      ]

      # remove duplicate information
      options.delete(:realty_type)

      super(options)

      update_attributes(:usage)
      update_attributes(:marketing_type)
    end

    def type_id
      @attributes[:user_defined_simplefield].first[:value]
    end

    def sub_type_id
      @attributes[:user_defined_simplefield][2][:value]
    end

    private

    def update_attributes(name)
      tmp = @attributes[name].transform_keys { |k| k.to_s.sub(/^@/, '').to_sym }

      tmp.keys.each do |k|
        define_singleton_method("#{k}?") { @attributes[name][k] }
      end

      @attributes[name] = tmp.transform_values { |v| v == 1 ? true : false }
    end
  end
end
