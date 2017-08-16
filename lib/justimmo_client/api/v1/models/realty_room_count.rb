# frozen_string_literal: true

module JustimmoClient::V1
  class RealtyRoomCount < JustimmoBase
    attribute :store, Integer
    attribute :bathroom, Integer
    attribute :balcony_terrace, Integer
    attribute :balcony, Integer
    attribute :garden, Integer
    attribute :garage, Integer
    attribute :loggia, Integer
    attribute :basement, Integer
    attribute :toilet, Integer
    attribute :parking_space, Integer
    attribute :total, Integer

    def to_i
      total
    end

    def to_s
      to_i.to_s
    end

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
