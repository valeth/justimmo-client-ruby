# frozen_string_literal: true

require 'justimmo/cache'

module Justimmo
  module MemoryCache
    extend Justimmo::Cache

    @cache = {}

    class << self
      def get(key)
        @cache[key]
      end

      def set(key, data)
        @cache[key] = data
      end
    end
  end
end
