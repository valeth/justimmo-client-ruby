# frozen_string_literal: true

require 'digest'
require 'rest_client'
require 'justimmo/errors'
require 'justimmo/config'

module Justimmo::API
  # Generic query interface for the API.
  module Query
    # Sends a request to the API.
    def request(path, params = {})
      params = build_params(params)

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
        log.debug("Requesting #{response.request.url}")
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

    def log
      Justimmo::Config.logger
    end

    def build_params(params)
      params
    end

    def mapper
      raise Justimmo::NotImplemented, 'mapper'
    end

    def with_cache(key, &block)
      Justimmo::Config.cache.with_cache(key, &block)
    end
  end
end
