# frozen_string_literal: true

require "active_support/core_ext/numeric/time"
require "active_support/cache"
require "justimmo/core/config"

module Justimmo
  # Caching support
  module Caching
    class << self
      # Returns the current cache
      # @!attribute [rw] cache
      # @return [ActiveSupport::Cache::Store]
      def cache
        @cache ||= default_cache
      end

      def cache=(type, **options)
        opts = Justimmo::Config.cache_options.merge(options)
        @cache = ActiveSupport::Cache.lookup_store(type, options)
      end

      def default_cache
        store = Justimmo::Config.cache_store
        options = Justimmo::Config.cache_options
        ActiveSupport::Cache.lookup_store(store, options)
      end
    end

    def cache
      Caching.cache
    end

    def with_cache(key, **options)
      data = cache.read(key)

      if data.nil?
        data = yield
        cache.write(key, data, options)
      end

      data
    end
  end
end
