# frozen_string_literal: true

require "active_support/core_ext/numeric/time"
require "active_support/cache"
require "justimmo_client/core/config"

module JustimmoClient
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
        opts = JustimmoClient::Config.cache_options.merge(options)
        @cache = ActiveSupport::Cache.lookup_store(type, opts)
      end

      def default_cache
        store = JustimmoClient::Config.cache_store
        options = JustimmoClient::Config.cache_options
        ActiveSupport::Cache.lookup_store(store, options)
      end
    end

    def cache
      self.cache
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
