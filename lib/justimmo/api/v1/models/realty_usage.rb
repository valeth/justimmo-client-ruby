# frozen_string_literal: true

module Justimmo::V1
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
end
