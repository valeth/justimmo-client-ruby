# frozen_string_literal: true

require "virtus"

module JustimmoClient::V1
  # @api private
  class JustimmoBase
    include JustimmoClient::Logging
    include JustimmoClient::Utils

    # :nodoc:
    include Virtus.model do |mod|
      mod.nullify_blank = true
      mod.coercer.config.string.boolean_map = { "0" => false, "1" => true }
    end

    # Dummy method for FactoryGirl
    def save!
    end

    def to_h
      deep_to_h
    end

    def ==(other)
      return true if equal?(other)
      return false unless other.is_a?(JustimmoBase)
      to_h == other.to_h
    end

    private

    def array_to_h(array)
      array.map do |elem|
        if elem.respond_to?(:to_h)
          elem.to_h
        else
          elem
        end
      end
    end

    def deep_to_h
      attributes.inject({}) do |acc, (key, value)|
        case value
        when Array        then acc.update(key => array_to_h(value))
        when JustimmoBase then acc.update(key => value.to_h)
        else                   acc.update(key => value)
        end
      end
    end
  end
end
