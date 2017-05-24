# frozen_string_literal: true

require 'json'
require 'set'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/hash/deep_merge'
require 'justimmo/errors'

module Justimmo::API
  # A generic resource.
  # Automatically generates getters and setters for attributes.
  class Resource
    class << self
      def from_xml(data)
        Justimmo::Parser.parse(data)
      end

      def from_json(data)
        tmp = data.is_a?(String) ? JSON.parse(data) : data
        new(tmp)
      end
    end

    def initialize(options)
      options ||= {}
      options = mapper.apply_to(options, &formatter)

      @attributes = @attributes.zip([nil]).to_h

      yield(options) if block_given?

      @attributes.deep_merge!(options)

      # build getters and setters
      @attributes.keys.each do |key|
        meth = [true, false].include?(@attributes[key]) ? "#{key}?" : key
        define_singleton_method(meth.to_sym) { @attributes[key] }
      end
    end

    def to_h
      tmp = {}
      @attributes.each do |key, value|
        tmp[key] =
          case value
          when Resource then value.to_h
          else value
          end
      end
      tmp
    end

    def to_json(options = nil)
      JSON.generate(@attributes, options)
    end

    private

    def mapper
      raise Justimmo::NotImplemented, 'mapper'
    end

    def formatter
      proc do |mapper, key|
        match = /^@(?<k>.*)/.match(key)
        if match
          "@#{mapper[match[:k]]}".to_sym
        else
          (mapper[key] || key).to_sym
        end
      end
    end
  end
end
