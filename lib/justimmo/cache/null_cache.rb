# frozen_string_literal: true

require 'justimmo/cache'

module Justimmo
  module NullCache
    extend Justimmo::Cache

    class << self
      def get(_key)
        nil
      end

      def set(_key, _data)
        nil
      end
    end
  end
end
