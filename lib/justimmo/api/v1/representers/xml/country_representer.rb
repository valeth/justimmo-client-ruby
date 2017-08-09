# frozen_string_literal: true

module Justimmo::V1
  module XML
    class CountryRepresenter < JustimmoRepresenter
      property :id
      property :name
      property :iso2
      property :iso3
    end
  end
end
