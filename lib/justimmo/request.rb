require 'rest_client'

module Justimmo
  module Request
    AuthenticationFailed = Class.new(JustimmoError)
    RetrievalFailed      = Class.new(JustimmoError)

    module_function

    def get(node, params = {})
      url = "#{Justimmo::Config.url}/#{node}"
      options = {
        params: params,
        Authorization: "Basic #{Justimmo::Config.credentials}"
      }
      raw_request(url, options)
    end

    def raw_request(url, params = {})
      response = RestClient.get(url, params)
      LOGGER.debug(response.request.url)
      response.body
    rescue RestClient::Unauthorized
      raise AuthenticationFailed, 'Authentication failed.'
    rescue RestClient::BadRequest, RestClient::NotFound => err
      LOGGER.error(err.response.request.url)
      raise RetrievalFailed, err.response.body
    rescue RestClient::InternalServerError
      raise RetrievalFailed, 'Internal server error'
    end
  end
end
