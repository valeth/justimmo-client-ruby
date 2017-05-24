# frozen_string_literal: true

require 'justimmo/api/v1/realty_resource'

module Justimmo::API
  # Holds price information like rent and purcase price.
  class Price < RealtyResource
    def initialize(options = {})
      @attributes = %i[
        currency
        price additional_costs
        maintenance_cost_net heating_cost_net additional_costs_net
        purcase_price purcase_price_net
        purcase_price_gross monthly_cost_net monthly_cost_gross
        rent_sum_net
        rent_total_net rent_total_gross montly_cost_net monthly_cost_gross
      ]

      super(options) do |opts|
        yield(@attributes.keys, opts)
        iso_currency(opts)
        opts[:price] = (opts[:purcase_price_net] || opts[:rent_total_net])
      end
    end

    def to_s
      "#{@attributes[:price].to_f} #{@attributes[:currency]}"
    end

    def inspect
      "<Price: #{self}>"
    end

    private

    def iso_currency(options)
      options[:currency] = options.dig(:currency, :@iso_currency) || options[:currency]
    end
  end
end
