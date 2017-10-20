module JustimmoClient::V1
  module JSON
    class RealtyPriceRepresenter < JustimmoRepresenter
      %i[
        purcase
        purcase_net
        rent
        rent_net
        rent_cold
        rent_including_heating
        deposit
        rent_per_sqm
        operating_cost
        operating_cost_net
        operating_cost_per_sqm
      ].each do |k|
        property k,
          setter: ->(represented:, fragment:, **) { represented.public_send("#{k}=", fragment) },
          getter: ->(represented:, **) { represented.public_send(k)&.to_f }
      end

      property :currency,
        setter: ->(represented:, fragment:, **) { represented.currency = fragment },
        getter: ->(represented:, **) { represented.currency&.id }

      property :commission,
        setter: ->(represented:, fragment:, **) { represented.commission = fragment },
        getter: ->(represented:, **) { represented.instance_variable_get(:@commission) }

      property :rent_vat,
        setter: ->(represented:, fragment:, **) { represented.rent_vat = fragment },
        getter: ->(represented:, **) { represented.instance_variable_get(:@rent_vat) }

      property :provision
      property :including_vat
      property :on_demand

      property :real_estate_taxes
      property :land_registry
      property :operating_cost_vat
    end
  end
end
