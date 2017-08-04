# frozen_string_literal: true

require "active_model"
require "active_support/core_ext/hash/keys"

module Justimmo::V1
  class Base
    include ActiveModel::Model
    include ActiveModel::Serializers::JSON

    def attributes
      instance_variables.map { |e| [e[1..-1].to_sym, instance_variable_get(e)] }.to_h
    end

    def attributes=(hash)
      hash.deep_symbolize_keys.each do |key, value|
        send("#{key}=", value)
      end
    end
  end
end
