# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyPriceRepresenter < JustimmoRepresenter
      nested :waehrung do
        property :currency, as: :iso_waehrung, attribute: true
      end

      property :purcase,     as: :kaufpreis
      property :purcase_net, as: :kaufpreisnetto
      nested :kaufpreis do
        property :on_demand, as: :auf_anfrage, attribute: true
      end

      nested :miete do
        property :rent,     as: :brutto
        property :rent_net, as: :netto
        property :rent_vat, as: :ust
      end

      property :deposit,                as: :kaution
      property :rent_cold,              as: :kaltmiete
      property :rent_including_heating, as: :warmmiete
      property :rent_per_sqm,           as: :mietpreis_pro_qm
      property :operating_cost_per_sqm, as: :betriebskosten_pro_qm

      property :provision,     as: :provisionspflichtig
      property :including_vat, as: :zzg_mehrwertsteuer
      property :commission,    as: :aussen_courtage

      property :real_estate_taxes,
        as: :user_defined_simplefield,
        parse_filter: ->(_fragment, options) do
          options[:doc].css("user_defined_simplefield[feldname=grunderwerbssteuer]").text
        end

      property :land_registry,
        as: :user_defined_simplefield,
        parse_filter: ->(_fragment, options) do
          options[:doc].css("user_defined_simplefield[feldname=grundbucheintragung]").text
        end

      nested :zusatzkosten do
        nested :betriebskosten do
          property :operating_cost,     as: :brutto
          property :operating_cost_net, as: :netto
          property :operating_cost_vat, as: :ust
        end
      end
    end
  end
end
