# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyRepresenter < JustimmoRepresenter
      nested :category, as: :objektkategorie do
        property :usage, as: :nutzungsart, class: RealtyUsage do
          property :living,     as: :WOHNEN,  attribute: true
          property :business,   as: :GEWERBE, attribute: true
          property :investment, as: :ANLAGE,  attribute: true
        end

        property :marketing, as: :vermarktungsart, class: RealtyMarketing do
          property :buy,  as: :KAUF,        attribute: true
          property :rent, as: :MIETE_PACHT, attribute: true
        end

        property :type_id,
          as: :user_defined_simplefield,
          parse_filter: ->(_fragment, options) do
            options[:doc].css("user_defined_simplefield[feldname=objektart_id]").text
          end

        property :sub_type_id,
          as: :user_defined_simplefield,
          parse_filter: ->(_fragment, options) do
            options[:doc].css("user_defined_simplefield[feldname=sub_objektart_id]").text
          end
      end
    end
  end
end
