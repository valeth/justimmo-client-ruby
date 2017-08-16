# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyRoomCountRepresenter < JustimmoRepresenter
      { store:            :anzahl_abstellraum,
        bathroom:         :anzahl_badezimmer,
        balcony_terrace:  :anzahl_balkon_terrassen,
        balcony:          :anzahl_balkone,
        garden:           :anzahl_garten,
        garage:           :anzahl_garagen,
        loggia:           :anzahl_loggias,
        basement:         :anzahl_keller,
        toilet:           :anzahl_sep_wc,
        parking_space:    :anzahl_stellplaetze,
        total:            :anzahl_zimmer
      }.each do |key, api|
        property key, as: api
      end
    end
  end
end
