# frozen_string_literal: true

module JustimmoClient::V1
  class RealtyPrice < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :currency,               Symbol, default: :EUR
    attribute :provision,              Boolean
    attribute :including_vat,          Boolean
    attribute :on_demand,              Boolean
    attribute :real_estate_taxes,      Float
    attribute :land_registry,          Float
    attribute :commission,             String
    attribute :rent_vat,               Integer
    attribute :operating_cost_vat,     Integer
    attribute :purcase,                RealtyCost
    attribute :purcase_net,            RealtyCost
    attribute :rent,                   RealtyCost
    attribute :rent_net,               RealtyCost
    attribute :rent_cold,              RealtyCost
    attribute :rent_cold_net,          RealtyCost
    attribute :rent_including_heating, RealtyCost
    attribute :rent_per_sqm,           RealtyCost
    attribute :operating_cost,         RealtyCost
    attribute :operating_cost_net,     RealtyCost
    attribute :operating_cost_per_sqm, RealtyCost
    attribute :deposit,                RealtyCost

    # @!group Instance Method Summary

    %i[
      purcase purcase_net deposit
      rent rent_net rent_cold rent_cold_net rent_including_heating rent_per_sqm
      operating_cost operating_cost_net operating_cost_per_sqm
    ].each do |meth|
      define_method("#{meth}=") do |args|
        options =
          case args
          when Hash   then args.deep_symbolize_keys
          when String then { amount: args, currency: @currency }
          else return
          end
        instance_variable_set("@#{meth}", RealtyCost.new(options))
      end
    end

    def on_demand?
      return on_demand if on_demand
      return purcase.zero? if purcase
      return rent.zero? if rent
      true
    end

    def rent?
      !rent.nil?
    end

    def purcase?
      !purcase.nil?
    end

    # TODO: add more additional costs
    def additional
      [operating_cost].map(&:to_f).sum
    end

    def get
      @purcase || @rent
    end

    def to_f
      get.to_f
    end

    def to_s
      on_demand? ? translate("price.on_demand") : get.to_s
    end
  end
end
