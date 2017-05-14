# frozen_string_literal: true

require 'base64'

module Justimmo
  class ConfigurationError < JustimmoError
    def initialize(missing)
      super "Required configuration missing: #{missing}"
    end
  end

  class Config
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
