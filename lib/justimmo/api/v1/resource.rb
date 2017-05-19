# frozen_string_literal: true

require 'json'
require 'set'
require 'active_support/core_ext/string/inflections'

module Justimmo::API
  # A generic resource.
  # Automatically generates getters and setters for attributes.
  class Resource
    class << self
      def query
        "Justimmo::API::#{class_name}Query".constantize
      end

      def mapper
        "Justimmo::API::#{class_name}Mapper".constantize
      end

      def class_name
        name.split('::').last
      end

      def from_json(data)
        tmp = data.is_a?(String) ? JSON.parse(data) : data
        tmp.deep_symbolize_keys!
        new(tmp)
      end
    end

    def initialize(options)
      options ||= {}

      @attributes = @attributes.zip([nil]).to_h.merge(options)

      yield(@attributes) if block_given?

      # build getters and setters
      @attributes.keys.each do |key|
        meth = [true, false].include?(@attributes[key]) ? "#{key}?" : key
        define_singleton_method(meth.to_sym) { @attributes[key] }
      end
    end

    def to_h
      @attributes
    end

    def to_json(options = nil)
      JSON.generate(@attributes, options)
    end
  end
end
