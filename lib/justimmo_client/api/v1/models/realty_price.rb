# frozen_string_literal: true

require "monetize"

module JustimmoClient::V1
  class RealtyPrice < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :currency,               Money::Currency
    attribute :provision,              Boolean
    attribute :including_vat,          Boolean
    attribute :on_demand,              Boolean
    attribute :real_estate_taxes,      Float
    attribute :land_registry,          Float
    attribute :commission,             Integer
    attribute :purcase,                Money
    attribute :purcase_net,            Money
    attribute :rent_vat,               Integer
    attribute :rent,                   Money
    attribute :rent_net,               Money
    attribute :rent_cold,              Money
    attribute :rent_including_heating, Money
    attribute :rent_per_sqm,           Money
    attribute :deposit,                Money
    attribute :operating_cost_vat,     Integer
    attribute :operating_cost,         Money
    attribute :operating_cost_net,     Money
    attribute :operating_cost_per_sqm, Money

    # @!group Instance Method Summary

    %w[purcase purcase_net
       operating_cost operating_cost_net operating_cost_per_sqm
       rent rent_net rent_cold rent_including_heating rent_per_sqm deposit
    ].each do |meth|
      define_method("#{meth}=") do |amount|
        # log.debug("Using currency #{currency.name} for #{meth}")
        instance_variable_set("@#{meth}", Monetize.parse(amount))
      end
    end

    def on_demand?
      return on_demand unless on_demand.nil?
      return purcase.zero? unless purcase.nil?
      return rent.zero? unless rent.nil?
      true
    end

    def rent?
      !rent.nil?
    end

    def purcase?
      !purcase.nil?
    end

    def currency=(cur)
      return if cur.nil?
      @currency = Money::Currency.new(cur)
      Money.default_currency = @currency
      log.debug("Set currency to #{currency.name}")
    end

    # FIXME: this needs some proper analysis of the input string
    def commission=(text)
      @commission = text.to_i
    end

    def commission
      return nil unless @commission

      if purcase?
        (get / 100 * @commission) * 1.20
      else
        (get * @commission) * 1.20
      end
    end

    def rent_vat
      return nil unless rent? && rent_net
      rent_net / 100 * @rent_vat
    end

    def get
      @purcase || @rent
    end

    def to_f
      get.to_f
    end

    def to_s
      on_demand? ? "on demand" : get.format
    end

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
