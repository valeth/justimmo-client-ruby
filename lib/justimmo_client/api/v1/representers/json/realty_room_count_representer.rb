# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyRoomCountRepresenter < JustimmoRepresenter
      %i[
        store
        bathroom
        balcony_terrace
        balcony
        garden
        garage
        loggia
        basement
        toilet
        parking_space
        total
      ].each { |k| property k }
    end
  end
end
