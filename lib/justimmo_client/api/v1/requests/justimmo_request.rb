# frozen_string_literal: true

require "rest_client"
require "digest"

module JustimmoClient::V1
  module JustimmoRequest
    include JustimmoClient::Logging
    include JustimmoClient::Caching

    # TODO: add retry logic
    def get(path, params = {})
      with_cache(cache_key(path, params)) do
        options = {
          params: build_params(params),
          Authorization: "Basic #{JustimmoClient::Config.credentials}"
        }

        uri = "#{JustimmoClient::Config.url}/#{path}"

        with_error_handler do
          log.debug("Requesting #{uri} with params #{options[:params]}")
          response = RestClient.get(uri, options)
          response.body
        end
      end
    end

    def with_error_handler
      yield
    rescue RestClient::Unauthorized
      logger.error("Authentication failed")
      raise JustimmoClient::AuthenticationFailed
    rescue RestClient::BadRequest, RestClient::NotFound, RestClient::InternalServerError => e
      log.error("Response: #{e.message}")
      raise JustimmoClient::RetrievalFailed, e.message
    end

    # TODO: Parse internal params to JI params
    def build_params(params)
      params
    end

    def cache_key(path, params)
      key = Digest::SHA256.new
      key << path
      key << params.to_s
      key.hexdigest
    end
  end
end
