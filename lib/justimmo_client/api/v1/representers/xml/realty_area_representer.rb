# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyAreaRepresenter < JustimmoRepresenter
      { balcony_terrace:  :balkon_terrasse_flaeche,
        balcony:          :balkons_flaeche,
        office:           :bueroflaeche,
        garage:           :garagen_flaeche,
        garden:           :gartenflaeche,
        total:            :gesamtflaeche,
        surface:          :grundflaeche,
        property:         :grundstuecksflaeche,
        basement:         :kellerflaeche,
        storage:          :lagerflaeche,
        loggia:           :loggias_flaeche,
        floor:            :nutzflaeche,
        parking:          :stellplatz_flaeche,
        terrace:          :terrassen_flaeche,
        buildable:        :verbaubare_flaeche,
        sales:            :verkaufsflaeche,
        living:           :wohnflaeche
      }.each do |key, api|
        property key, as: api
      end
    end
  end
end
