# frozen_string_literal: true

require 'active_support/core_ext/numeric/time'
require 'active_support/cache'

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
        @cache = ActiveSupport::Cache.lookup_store(type, options)
      end

      def default_cache
        @cache = ActiveSupport::Cache.lookup_store(:memory_store)
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
