# frozen_string_literal: true

require 'yaml'
require 'active_support/core_ext/string/inflections'
require 'active_support/core_ext/hash/deep_merge'
require 'active_support/core_ext/hash/indifferent_access'

module Justimmo::API
  # Maps values to other values.
  module Mapper
    # A mapping could not be found in the mappings hash.
    class MappingNotFound < StandardError
      def initialize(map)
        super("Could not find #{map} mapping.")
      end
    end

    # A key could not be found in the specified mapping.
    class KeyNotFound < StandardError
      def initialize(key, map)
        super("Key #{key} not found in #{map} mapping.")
      end
    end

    DICTIONARY_PATH = File.join(__dir__, 'dictionaries')

    # Defines the action that's being used on errors
    # @param key [Symbol]
    #   The action to use, can be :ignore, :convert, :raise or :mark.
    # @return [Symbol] The current setting.
    def on_mapper_error(key = nil)
      @on_mapper_error ||= Justimmo::Config.on_mapper_error
      return @on_mapper_error unless key.respond_to?(:to_sym)
      key.nil? ? @on_mapper_error : @on_mapper_error = key.to_sym
    end

    # The module name without the leading path
    # @return [String] The module name.
    def module_name
      name.split('::').last
    end

    # The path to the dictionary for this mapper.
    # @return [String] The dictionary path.
    def dictionary
      filename = "#{module_name.underscore.split('_').first}.yml"
      File.join(DICTIONARY_PATH, filename)
    end

    # The content of the dictionary file as Ruby hash.
    # @return [Hash] Parsed YAML file.
    def load_dictionary
      YAML.load_file(dictionary)
    end

    # The content of the generic dicitonary for all mappers.
    # @return [Hash] Parsed YAML file.
    def generic_mapping
      hash = YAML.load_file(File.join(DICTIONARY_PATH, 'generic.yml'))
      hash.with_indifferent_access
    end

    # Get all mappings from this mapper. Will initialize on first call.
    # @return [Hash] The mappings hash.
    def mappings
      return @mappings unless @mappings.nil?
      @mappings ||= generic_mapping
      @mappings.deep_merge!(load_dictionary)
      @mappings = @mappings.with_indifferent_access
      @mappings.freeze
    end

    # Gets a specific mapping from the mappings hash.
    # @param map [String, Symbol] The mapping.
    # @raise [MappingNotFound]
    # @return [Hash] Mapping content.
    def mapping(map)
      mappings.fetch(map)
    rescue KeyError
      raise MappingNotFound, map
    end

    # Get a key from a mapping.
    # @param key [String, Symbol]
    #   The key to search for.
    # @param map [String, Symbol]
    #   The map to search in. Defaults to :main.
    # @param reverse [Boolean]
    #   Look up keys instead of values. Defaults to false.
    # @raise [KeyNotFound]
    #   If on_mapper_error is set to :raise.
    # @return [Symbol]
    #  The value, if found, nil if on_mapper_error is set to :ignore.
    def get(key, map: :main, reverse: false)
      return nil unless key.respond_to?(:to_s)
      handle_key_error(key, map) do
        if reverse
          mapping(map).key(key.to_s)&.to_sym
        else
          mapping(map).fetch(key, nil)&.to_sym
        end
      end
    end

    alias [] get

    def keys(map = :main)
      return [] unless mapping?(map)
      mapping(map).keys.map(&:to_sym)
    end

    def values(map = :main)
      return [] unless mapping?(map)
      mapping(map).values.map(&:to_sym)
    end

    # Check if a mapping is available.
    # @param map [String, Symbol] The mapping to look up.
    # @return [true, false]
    def mapping?(map)
      mappings.key?(map)
    end

    # Handle key lookup errors.
    # @param key [String, Symbol]
    # @param map [String, Symbol]
    # @raise [KeyNotFoundError] If on_mapper_error is set to :raise.
    # @return [String, Symbol] Return value depends on on_mapper_error setting.
    def handle_key_error(key, map)
      val = yield
      return val.to_sym unless val.nil?
      case on_mapper_error
      when :raise  then raise KeyNotFound.new(key, map)
      when :mark   then "!#{key.upcase}"
      else         key.respond_to?(:to_sym) ? key.to_sym : key
      end
    end
  end
end
