# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class CountryRepresenter < JustimmoRepresenter
      self.representation_wrap = :land

      property :id
      property :alpha2, as: :iso2
      property :alpha3, as: :iso3

      collection_representer class: Country
    end
  end
end
