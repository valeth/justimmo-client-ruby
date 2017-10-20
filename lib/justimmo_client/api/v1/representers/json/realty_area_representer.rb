# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyAreaRepresenter < JustimmoRepresenter
      %i[
        balcony_terrace
        balcony
        office
        garage
        garden
        total
        surface
        property
        basement
        storage
        loggia
        floor
        parking
        terrace
        buildable
        sales
        living
      ].each { |k| property k }
    end
  end
end
