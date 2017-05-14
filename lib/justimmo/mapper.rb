require 'active_support'
require 'active_support/core_ext'

module Justimmo
  MappingNotFound = Class.new(JustimmoError)
  KeyNotFound     = Class.new(JustimmoError)

  # Maps internal keys and values to API ones
  module Mapper
    # Get a key from the specified mapping, defaults to @mapping.
    # @param key [String, Symbol] The key used to look up the value.
    # @param map [Symbol] The hash to search. Default is nil.
    # @param reverse [true, false] Search for keys instead of values. Default is false.
    # @return [Symbol, nil] The value or nil if not found.
    def get(key, map: nil, reverse: false)
      raise MappingNotFound, "Could not find #{map} mapping." unless mapping?(map)

      key = format_key(key)
      map_name = mapping_name(map)

      handle_mapper_error(key, map_name) do
        mapping = instance_variable_get(map_name)
        (reverse ? mapping.key(key) : mapping[key])
      end
    end

    alias [] get

    # Get all keys from a mapping
    # @param map [String, Symbol] The mapping to search. Default is :mapping.
    # @return [Array] The keys for the given mapping or empty array.
    def keys(map = nil)
      return [] unless mapping?(map)

      map_name = mapping_name(map)

      instance_variable_get(map_name).keys
    end

    # Get all values from a mapping
    # @param  map  The mapping to search. Default is :mapping.
    # @return [Array] The values for the given mapping or empty array.
    def values(map = nil)
      return [] unless mapping?(map)

      map_name = mapping_name(map)

      instance_variable_get(map_name).values
    end

    def each(map = nil)
      return {} unless mapping?(map)

      map_name = mapping_name(map)

      instance_variable_get(map_name).each do |key, value|
        yield(key, value)
      end
    end

    # @param name [String, Symbol]
    # @param order [Symbol]
    # @return [Symbol, nil]
    # def filter_order(name, order: :asc)
    #   key = get(name, map: :filter)
    #   return nil if key.nil?
    #   case order
    #   when :asc  then "#{key}_von".to_sym
    #   when :desc then "#{key}_bis".to_sym
    #   end
    # end

    def mapping?(name = nil)
      instance_variable_defined?(mapping_name(name))
    end

    module_function

    def format_key(key)
      key = key.to_s.underscore if key.respond_to?(:to_s)
      key.to_sym if key.respond_to?(:to_sym)
    end

    def mapping_name(name)
      map_name = [name, 'mapping'].compact.map(&:to_s).uniq.join('_')
      "@#{map_name}"
    end

    def handle_mapper_error(key, map_name)
      result = yield

      case Justimmo::Config.on_mapper_error
      when :raise
        raise KeyNotFound, "Key #{key} not found in #{map_name}." if result.nil?
      when :mark
        return "#{key.upcase}!" if result.nil?
      end

      result
    end
  end
end
