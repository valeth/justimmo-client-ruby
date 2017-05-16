# frozen_string_literal: true

require 'base64'

module Justimmo
  # Holds configuration for the Justimmo API.
  class Config
    # Raised when configuration validation fails.
    class ConfigurationError < JustimmoError
      def initialize(missing)
        super "Required configuration missing: #{missing}"
      end
    end

    DEFAULTS = {
      base_url: 'https://api.justimmo.at/rest',
      api_ver:  1,
      username: nil,
      password: nil,
      on_mapper_error: :mark,
      debug: false
    }.freeze

    REQUIRED = %i[username password].freeze

    # global config
    @config = nil

    # Justimmo API configuration.
    # The configuration options are validated on creation.
    # @param  options [Hash]  The configuration attributes.
    # @option  options [String]  :base_url  The first part of the request URL.
    # @option  options [Integer]  :api_ver  The API version.
    # @option  options [String]  :username  The username for authentication.
    # @option  options [String]  :password  The password for authentication.
    # @option  options [Symbol]  :on_mapper_error  The action to use when a mapper lookup fails.
    # @option  options [Boolean]  :debug  Enable debug mode.
    # @yield  The block is used to configure the {Config} object.
    # @yieldparam  config [self]
    def initialize(options = {})
      @attributes = DEFAULTS.merge(options)

      @attributes.each do |key, value|
        define_singleton_method("#{key}=") { |x| @attributes[key] = x }

        meth = [true, false].include?(value) ? "#{key}?" : key
        define_singleton_method(meth) { @attributes[key] }
      end

      yield(self) if block_given?

      validate
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
      raise ConfigurationError, missing unless missing.empty?
    end

    class << self
      # Convenience method that sets configuration.
      # @yield  The configuration block.
      # @yieldparam  config [Justimmo::Config]  The configuration object.
      def configure(options = {})
        @config =
          new(options) do |config|
            yield(config) if block_given?
          end
      end

      def clear
        @config = nil
      end

      DEFAULTS.each do |key, value|
        meth = [true, false].include?(value) ? "#{key}?" : key
        define_method(meth) { @config&.send(meth) || DEFAULTS[key] }
      end

      def url
        @config&.url || "#{DEFAULTS[:base_url]}/v#{DEFAULTS[:api_ver]}"
      end

      def credentials
        @config&.credentials
      end
    end
  end
end
