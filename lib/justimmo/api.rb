require 'rest_client'

module Justimmo
  # API request handling.
  module API
    # Generic query interface for the API.
    module Query
      class AuthenticationFailed < JustimmoError
        def initialize
          super('Authentication failed.')
        end
      end

      class RetrievalFailed < JustimmoError
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
        "Justimmo::Mapper::#{map}Mapper".constantize
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
        response = RestClient.get(url, params)
        Logger.debug(response.request.url)
        response.body
      rescue RestClient::Unauthorized
        raise AuthenticationFailed
      rescue RestClient::BadRequest, RestClient::NotFound => err
        Logger.error(err.response.request.url)
        raise RetrievalFailed, err.response.body
      rescue RestClient::InternalServerError
        raise RetrievalFailed, 'Internal server error'
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
    end
  end
end
