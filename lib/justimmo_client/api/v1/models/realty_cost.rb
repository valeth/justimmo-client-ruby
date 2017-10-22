# frozen_string_literal: true

require "monetize"

module JustimmoClient::V1
  class Money < Virtus::Attribute
    def coerce(value)
      ::Monetize.parse(value)
    end
  end

  class Currency < Virtus::Attribute
    include JustimmoClient::Logging

    def coerce(value)
      ::Money::Currency.new(value)
    rescue ::Money::Currency::UnknownCurrency
      ::Money.default_currency
    end
  end

  class RealtyCost < JustimmoBase
    attribute :currency, Currency
    attribute :amount,   Money

    def /(other)
      amount / other
    end

    def *(other)
      amount * other
    end

    def +(other)
      amount + ::Money.new(other)
    end

    def -(other)
      amount - ::Money.new(other)
    end

    def zero?
      amount.zero?
    end

    def to_s
      amount.format
    end

    def to_f
      amount.to_f
    end

    def to_h
      { currency: currency.id, amount: amount.to_f }
    end

    def to_json(options = nil)
      to_h.to_json(options)
    end

    alias as_json to_json

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
