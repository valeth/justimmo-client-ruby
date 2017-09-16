# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyCategoryRepresenter < JustimmoRepresenter
      property :usage, class: RealtyUsage do
        property :living
        property :business
        property :investment
      end

      property :marketing, class: RealtyMarketing do
        property :buy
        property :rent
      end

      property :type_id
      property :sub_type_id
    end
  end
end