# frozen_string_literal: true

require "base64"
require "active_support/configurable"
require "justimmo_client/errors"

module JustimmoClient
  # Configuration options storage
  # @api private
  class Config
    include ActiveSupport::Configurable

    SUPPORTED_API_VERSIONS = [1].freeze
    REQUIRED = %i[username password].freeze

    config_accessor(:base_url) { ENV.fetch("JUSTIMMO_BASE_URL", "api.justimmo.at/rest") }
    config_accessor(:secure) { true }
    config_accessor(:api_ver) { 1 }
    config_accessor(:username) { ENV.fetch("JUSTIMMO_USERNAME", nil) }
    config_accessor(:password) { ENV.fetch("JUSTIMMO_PASSWORD", nil) }
    config_accessor(:credentials)
    config_accessor(:debug) { false }
    config_accessor(:cache) { nil }
    config_accessor(:request_retries) { 3 }
    config_accessor(:proxy) { ENV.fetch("JUSTIMMO_PROXY", nil) }

    class << self
      def configure
        super
        self.credentials = Base64.urlsafe_encode64("#{username}:#{password}")
        validate_api_version
      end

      def validate_credentials
        missing = REQUIRED.select { |r| @_config[r].nil? }
        raise JustimmoClient::MissingConfiguration, missing unless missing.empty?
      end

      def validate_api_version
        supported_ver = SUPPORTED_API_VERSIONS.include?(api_ver)
        raise JustimmoClient::UnsupportedAPIVersion, api_ver unless supported_ver
      end

      def url
        validate_credentials
        return "#{base_url}/v#{api_ver}" if self.base_url.start_with?("http")
        "#{secure ? 'https' : 'http'}://#{base_url}/v#{api_ver}"
      end
    end
  end
end
