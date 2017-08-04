# frozen_string_literal: true

require_relative "base"

module Justimmo
  module V1
    class RealtyCategory < Base
      attr_accessor :usage, :marketing, :type_id, :sub_type_id
    end

    class RealtyUsage < Base
      attr_accessor :living, :business, :investment

      def living?
        @living
      end

      def business?
        @business
      end

      def investment?
        @investment
      end
    end

    class RealtyMarketing < Base
      attr_accessor :buy, :rent
    end
  end
end
