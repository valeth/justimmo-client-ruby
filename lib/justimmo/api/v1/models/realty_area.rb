# frozen_string_literal: true

module Justimmo::V1
  class RealtyArea < JustimmoBase
    attribute :balcony_terrace, Float
    attribute :balcony, Float
    attribute :office, Float
    attribute :garage, Float
    attribute :garden, Float
    attribute :total, Float
    attribute :surface, Float
    attribute :property, Float
    attribute :basement, Float
    attribute :storage, Float
    attribute :loggia, Float
    attribute :floor, Float
    attribute :parking, Float
    attribute :terrace, Float
    attribute :buildable, Float
    attribute :sales, Float
    attribute :living, Float

    def inspect
      "#<#{self.class} #{living}>"
    end

    def each(&block)
      attributes.each(&block)
    end

    def map(&block)
      attributes.map(&block)
    end
  end
end
