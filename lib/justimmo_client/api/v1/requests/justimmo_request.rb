# frozen_string_literal: true

require "rest_client"
require "digest"
require "retriable"

module JustimmoClient::V1
  module JustimmoRequest
    include JustimmoClient::Logging
    include JustimmoClient::Caching

    def get(path, params = {})
      with_cache(cache_key(path, params)) { request(path, params) }
    end

    def request(path, params = {})
      uri = "#{JustimmoClient::Config.url}/#{path}"

      options = {
        params: build_params(params),
        Authorization: "Basic #{JustimmoClient::Config.credentials}"
      }

      with_retries do
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
      log.error("Authentication failed")
      raise JustimmoClient::AuthenticationFailed
    rescue RestClient::BadRequest, RestClient::NotFound, RestClient::InternalServerError => e
      raise JustimmoClient::RetrievalFailed, e.message
    end

    def with_retries
      options = {
        base_interval: 2.0,
        tries: JustimmoClient::Config.request_retries,
        on_retry: proc do |exception, try, elapsed_time, next_interval|
          log.error("#{exception.class}: #{exception}")
          log.error("Try #{try} in #{elapsed_time} seconds, retrying in #{next_interval} seconds.")
        end,
        on: JustimmoClient::RetrievalFailed
      }

      Retriable.retriable(options) { yield }
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
