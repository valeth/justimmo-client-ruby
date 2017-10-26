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

      Retriable.retriable do
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
  end
end
