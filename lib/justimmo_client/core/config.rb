# frozen_string_literal: true

require "base64"
require "active_support/configurable"
require "justimmo_client/errors"

module JustimmoClient
  # @api private
  class Config
    include ActiveSupport::Configurable

    SUPPORTED_API_VERSIONS = [1].freeze
    REQUIRED = %i[username password].freeze

    config_accessor(:base_url) { "api.justimmo.at/rest" }
    config_accessor(:secure) { true }
    config_accessor(:api_ver) { 1 }
    config_accessor(:username)
    config_accessor(:password)
    config_accessor(:credentials)
    config_accessor(:debug) { false }
    config_accessor(:cache) { nil }
    config_accessor(:request_retries) { 3 }

    class << self
      def configure
        super
        self.credentials = Base64.urlsafe_encode64("#{username}:#{password}")
        validate
      end

      def validate
        missing = REQUIRED.select { |r| @_config[r].nil? }
        raise MissingConfiguration, missing unless missing.empty?

        supported_ver = SUPPORTED_API_VERSIONS.include?(api_ver)
        raise UnsupportedAPIVersion, api_ver unless supported_ver
      end

      def url
        "#{secure ? 'https' : 'http'}://#{base_url}/v#{api_ver}"
      end
    end
  end
end
