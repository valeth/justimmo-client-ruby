# frozen_string_literal: true
module Justimmo::V1
  class RealtyUsage < JustimmoBase
    attribute :living, Boolean
    attribute :business, Boolean
    attribute :investment, Boolean

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
