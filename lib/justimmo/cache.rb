# frozen_string_literal: true

require 'justimmo/errors'
require 'justimmo/config'

module Justimmo
  autoload :NullCache,   'justimmo/cache/null_cache'
  autoload :MemoryCache, 'justimmo/cache/memory_cache'
  autoload :RedisCache,  'justimmo/cache/redis_cache'

  module Cache
    def get(_key)
      raise Justimmo::NotImplemented, 'get'
    end

    def set(_key, _data)
      raise Justimmo::NotImplemented, 'set'
    end

    def with_cache(key)
      data = get(key)

      if data.nil?
        log.debug("Cache miss for key #{key}")
        data = yield
        set(key, data)
      else
        log.debug("Cache hit for key #{key}")
      end

      data
    end

    def log
      Justimmo::Config.logger
    end
  end
end
