module JustimmoClient::V1
  module JSON
    class RealtyPriceRepresenter < JustimmoRepresenter
      property :currency
      property :purcase
      property :purcase_net
      property :on_demand

      property :rent
      property :rent_net
      property :rent_vat

      property :deposit
      property :rent_cold
      property :rent_including_heating
      property :rent_per_sqm
      property :operating_cost_per_sqm

      property :provision
      property :including_vat
      property :commission

      property :real_estate_taxes
      property :land_registry

      property :operating_cost
      property :operating_cost_net
      property :operating_cost_vat
    end
  end
end
