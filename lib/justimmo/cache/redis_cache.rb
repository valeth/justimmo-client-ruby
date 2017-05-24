# frozen_string_literal: true

require 'justimmo/errors'
require 'justimmo/config'

begin
  require 'redis'
rescue LoadError
  raise Justimmo::InitializationError, 'Please install the "redis" gem to use this caching backend.'
end

module Justimmo
  module RedisCache
    extend Justimmo::Cache

    @redis = Redis.new(Justimmo::Config.cache_options)

    class << self
      def get(key)
        @redis.get(key)
      end

      def set(key, data)
        @redis.set(key, data)
      end
    end
  end
end
