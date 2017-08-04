# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RealtyCategoryRepresenter < JustimmoRepresenter
      boolean_filter = ->(frag, _opt) { frag == "1" }

      property :usage, as: :nutzungsart, class: RealtyUsage do
        property :living, as: :WOHNEN, attribute: true, parse_filter: boolean_filter
        property :business, as: :GEWERBE, attribute: true, parse_filter: boolean_filter
        property :investment, as: :ANLAGE, attribute: true, parse_filter: boolean_filter
      end

      property :marketing, as: :vermarktungsart, class: RealtyMarketing do
        property :buy, as: :KAUF, attribute: true, parse_filter: boolean_filter
        property :rent, as: :MIETE_PACHT, attribute: true, parse_filter: boolean_filter
      end

      type_id_filter = ->(_fragment, options) do
        options[:doc].css("user_defined_simplefield[feldname=objektart_id]").text
      end

      property :type_id,
        as: :user_defined_simplefield,
        parse_filter: type_id_filter,
        type: Integer

      sub_type_id_filter = ->(_fragment, options) do
        options[:doc].css("user_defined_simplefield[feldname=sub_objektart_id]").text
      end

      property :sub_type_id,
        as: :user_defined_simplefield,
        parse_filter: sub_type_id_filter,
        type: Integer
    end
  end
end
