# frozen_string_literal: true

require 'base64'
require 'justimmo/errors'
require 'justimmo/logger'
require 'justimmo/cache'

module Justimmo
  # Holds configuration for the Justimmo API.
  class Config
    DEFAULTS = {
      base_url: 'https://api.justimmo.at/rest',
      api_ver:  1,
      username: nil,
      password: nil,
      debug: false,
      cache: :memory,
      cache_options: {},
      logger: Justimmo::Logger,
      on_mapper_error: :convert
    }.freeze

    SUPPORTED_API_VERSIONS = [1].freeze

    REQUIRED = %i[username password].freeze

    # global config
    @config = nil

    class << self
      # Convenience method that sets configuration.
      # @yield  The configuration block.
      # @yieldparam  config [Justimmo::Config]  The configuration object.
      def configure(options = {})
        @config = new(options) { |config| yield(config) if block_given? }
      end

      def clear
        @config = nil
      end

      def url
        @config&.url || "#{DEFAULTS[:base_url]}/v#{DEFAULTS[:api_ver]}"
      end

      def credentials
        @config&.credentials
      end

      def configured?
        @config || false
      end

      DEFAULTS.each do |key, value|
        meth = [true, false].include?(value) ? "#{key}?" : key
        define_method(meth) { @config&.send(meth) || DEFAULTS[key] }
      end
    end

    # Justimmo API configuration.
    # The configuration options are validated on creation.
    # @param options [Hash]
    #   The configuration attributes.
    # @option options [String] :base_url
    #   The first part of the request URL.
    # @option options [Integer] :api_ver
    #   The API version.
    # @option options [String] :username
    #   The username for authentication.
    # @option options [String] :password
    #   The password for authentication.
    # @option options [Symbol] :on_mapper_error
    #   The action to use when a mapper lookup fails.
    # @option options [Boolean] :debug
    #   Enable debug mode.
    # @yield The block is used to configure the {Config} object.
    # @yieldparam config [self]
    def initialize(options = {})
      @attributes = DEFAULTS.merge(options)

      @attributes.keys.reject { |k| k == :api_ver }.each do |key|
        define_singleton_method("#{key}=") { |x| @attributes[key] = x }
      end

      @attributes.each do |key, value|
        meth = [true, false].include?(value) ? "#{key}?" : key
        define_singleton_method(meth) { @attributes[key] }
      end

      yield(self) if block_given?

      validate
      initialize_cache
    end

    def api_ver=(version)
      supported_ver = SUPPORTED_API_VERSIONS.include?(version)
      raise UnsupportedAPIVersion, version unless supported_ver
      @attributes[:api_ver] = version
    end

    def url
      "#{@attributes[:base_url]}/v#{@attributes[:api_ver]}"
    end

    def credentials
      username = @attributes[:username]
      password = @attributes[:password]
      @credentials ||= Base64.urlsafe_encode64("#{username}:#{password}")
    end

    private

    def validate
      missing = REQUIRED.select { |r| @attributes[r].nil? }
      raise MissingConfiguration, missing unless missing.empty?

      supported_ver = SUPPORTED_API_VERSIONS.include?(@attributes[:api_ver])
      raise UnsupportedAPIVersion, @attributes[:api_ver] unless supported_ver
    end

    def initialize_cache
      backend = "Justimmo::#{@attributes[:cache].to_s.camelize}Cache".constantize
      @attributes[:cache] = backend
    rescue Justimmo::InitializationError => e
      puts e.message
      backend = "Justimmo::#{DEFAULTS[:cache].to_s.camelize}Cache".constantize
      puts "Falling back to default cache backend: #{backend}"
      @attributes[:cache] = backend
    end
  end
end
