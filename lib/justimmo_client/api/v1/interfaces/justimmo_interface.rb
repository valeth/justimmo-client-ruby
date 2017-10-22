# frozen_string_literal: true

module JustimmoClient::V1
  module JustimmoInterface
    include JustimmoClient::Caching
    include JustimmoClient::Logging
    include JustimmoClient::API

    def cache_key(endpoint, params = {})
      key = Digest::SHA256.new
      key << endpoint
      key << params.to_s
      key.hexdigest
    end

    def with_cache(key, on_hit:, on_miss:, **options)
      log.debug("Looking up cache key #{key}")
      data = nil
      cached = cache.read(key)

      if cached.nil?
        log.debug("Cache miss for #{key}")
        data, new_cache = on_miss.call()
        cache.write(key, new_cache, options)
      else
        log.debug("Cache hit for #{key}")
        data = on_hit.call(cached)
      end

      data
    end
  end
end
