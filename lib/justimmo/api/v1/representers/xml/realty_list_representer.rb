# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RealtyListRepresenter < JustimmoRepresenter
      collection :realties,
        as: :immobilie,
        wraps: :immobilie,
        decorator: RealtyRepresenter,
        class: Realty
    end
  end
end
