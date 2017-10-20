# frozen_string_literal: true

require "rest_client"
require "digest"
require "retriable"

module JustimmoClient::V1
  # @api private
  module JustimmoRequest
    include JustimmoClient::Logging

    def get(path, params = {})
      request(path, params)
    end

    def request(path, params = {})
      uri = "#{JustimmoClient::Config.url}/#{path}"

      options = {
        params: params,
        Authorization: "Basic #{JustimmoClient::Config.credentials}"
      }

      with_retries do
        with_request_error_handler do
          log.debug("Requesting #{uri} with params #{options[:params]}")
          RestClient.proxy = JustimmoClient::Config.proxy
          log.debug("Using proxy: #{RestClient.proxy}") if RestClient.proxy
          response = RestClient.get(uri, options)
          response.body
        end
      end
    end

    def with_request_error_handler
      yield
    rescue RestClient::Unauthorized
      log.error("Authentication failed, check your configuration.")
      raise JustimmoClient::AuthenticationFailed
    rescue RestClient::Exception, SocketError, Errno::ECONNREFUSED => e
      raise JustimmoClient::RetrievalFailed, e
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
  end
end
