# frozen_string_literal: true

require 'rest_client'
require 'active_support/core_ext/string/inflections'
require 'justimmo/errors'
require 'justimmo/logger'

module Justimmo::API
  # Generic query interface for the API.
  module Query
    # Raised when authentication with the API fails.
    class AuthenticationFailed < Justimmo::JustimmoError
      def initialize
        super('Authentication failed.')
      end
    end

    # Raised when retrieval from the API fails.
    class RetrievalFailed < Justimmo::JustimmoError
      def initialize(message)
        super("Failed to get data from the API: #{message}")
      end
    end

    # The module name without the leading path
    # @return [String] The module name.
    def module_name
      name.split('::').last
    end

    # The mapper that this query is associated with.
    # @return [Module] The mapper module.
    def mapper
      map = module_name.underscore.split('_').first.capitalize
      "Justimmo::API::#{map}Mapper".constantize
    end

    # Sends a request to the API.
    # @see request
    def request(path, params = {})
      options = {
        params: params,
        Authorization: "Basic #{Justimmo::Config.credentials}"
      }

      raw_request(url(path), options)
    end

    # Executes the actual GET request.
    # @param params [Hash] The internal request parameters.
    # @raise [AuthenticationFailed] Credentials are missing or are incorrect.
    # @raise [RetrievalFailed] Some error occured and we got no valid response.
    # @return [String] The response body.
    def raw_request(url, params = {})
      with_error_handler do
        response = RestClient.get(url, params)
        log.debug(response.request.url)
        response.body
      end
    end

    # Build a request url.
    # @param path [String] The partial path to some API resource.
    # @return [String] The full API resource path.
    def url(path)
      "#{Justimmo::Config.url}/#{path}"
    end

    # Convert an internal value to an API value.
    # @param value The internal value.
    # @return The converted API value.
    def parse_value(value)
      case value
      when true then 1
      when false then 0
      else value
      end
    end

    def log
      Justimmo::Logger
    end

    def with_error_handler
      yield
    rescue RestClient::Unauthorized
      raise AuthenticationFailed
    rescue RestClient::BadRequest, RestClient::NotFound => err
      log.error(err.response.request.url)
      raise RetrievalFailed, err.response.body
    rescue RestClient::InternalServerError
      raise RetrievalFailed, 'Internal server error'
    end
  end
end
