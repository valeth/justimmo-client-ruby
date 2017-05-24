# frozen_string_literal: true

require 'yaml'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/hash/indifferent_access'
require 'justimmo/errors'

module Justimmo::API
  # Maps values to other values.
  class Mapper
    DICTIONARY_PATH   = File.join(__dir__, 'dictionaries')
    DEFAULT_MAPPING   = :main
    DEFAULT_DICT      = 'generic.yml'
    DEFAULT_FORMATTER = proc { |mapper, key| mapper[key].to_sym }

    class << self
      # Create a new mapper and put it into a global _registry_.
      def create(dict_name = nil)
        @mappers ||= {}
        @mappers[dict_name] ||= new(dict_name)
      end

      alias [] create
    end

    def initialize(dict_name = nil)
      dict = File.join(DICTIONARY_PATH, "#{dict_name}.yml")
      default_dict = File.join(DICTIONARY_PATH, DEFAULT_DICT)
      @mappings = YAML.load_file(default_dict).with_indifferent_access
      return unless dict_name
      @mappings.deep_merge!(YAML.load_file(dict))
    end

    # Get a key from a mapping.
    # @param key [String, Symbol]
    #   The key to search for.
    # @param map [String, Symbol]
    #   The map to search in. Defaults to :main.
    # @param reverse [Boolean] #   Look up keys instead of values. Defaults to false.
    # @raise [KeyNotFound]
    #   If on_mapper_error is set to :raise.
    # @return [Symbol]
    #  The value, if found, nil if on_mapper_error is set to :ignore.
    def get(key, map: DEFAULT_MAPPING, reverse: false)
      handle_key_error(key, map) do
        reverse ? mapping(map).key(key.to_s) : mapping(map)[key.to_s]
      end
    end

    alias [] get

    def keys(map = DEFAULT_MAPPING)
      return [] unless mapping?(map)
      mapping(map).keys
    end

    def values(map = DEFAULT_MAPPING)
      return [] unless mapping?(map)
      mapping(map).values
    end

    def apply_to(hash = {})
      hash.deep_transform_keys do |key|
        block_given? ? yield(self, key) : DEFAULT_FORMATTER.call(self, key)
      end
    end

    # Check if a mapping is available.
    # @param map [String, Symbol] The mapping to look up.
    # @return [true, false]
    def mapping?(map)
      @mappings.key?(map)
    end

    def on_mapper_error(key = nil)
      @on_mapper_error ||= Justimmo::Config.on_mapper_error
      return @on_mapper_error unless key.respond_to?(:to_sym)
      key.nil? ? @on_mapper_error : @on_mapper_error = key.to_sym
    end

    private

    def mapping(map)
      @mappings.fetch(map)
    rescue KeyError
      raise Justimmo::MappingNotFound, map
    end

    def handle_key_error(key, map)
      val = yield
      return val.to_sym unless val.nil?
      case on_mapper_error
      when :raise  then raise Justimmo::KeyNotFound.new(key, map)
      else         key.respond_to?(:to_sym) ? key.to_sym : key
      end
    end
  end
end
