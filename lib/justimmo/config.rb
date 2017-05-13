require 'base64'

module Justimmo
  class Config
    attr_accessor :username
    attr_accessor :password
    attr_accessor :api_ver
    attr_accessor :base_url
    attr_accessor :mapper_raises_error

    BASE_URL = 'https://api.justimmo.at/rest'.freeze
    API_VER  = 1

    @config = nil

    def initialize(username: nil, password: nil,
                   api_ver: API_VER, base_url: BASE_URL)
      @username = username
      @password = password
      @api_ver  = api_ver
      @base_url = base_url
      @mapper_raises_error = false
    end

    def url
      "#{@base_url}/v#{@api_ver}"
    end

    def credentials
      return if @username.nil? || @password.nil?
      @credentials ||= Base64.urlsafe_encode64("#{@username}:#{@password}")
    end

    def mapper_raises_error?
      @mapper_raises_error
    end

    class << self
      def configure(**attributes)
        @config = new(attributes)
        yield(@config) if block_given?
      end

      def credentials
        @config&.credentials
      end

      def url
        @config&.url || "#{BASE_URL}/v#{API_VER}"
      end

    def mapper_raises_error?
      @config&.mapper_raises_error? || false
    end
    end
  end
end
