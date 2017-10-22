# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyTypeRepresenter < JustimmoRepresenter
      self.representation_wrap = :objektart

      TRANSLATION_MAPPING = {
        "Zimmer" => :room,
        "Wohnung" => :apartment,
        "Haus" => :house,
        "Grundstück" => :property,
        "Büro / Praxis" => :office,
        "Einzelhandel" => :retail,
        "Gastgewerbe" => :hospitality,
        "Industrie / Gewerbe" => :business,
        "Land und Forstwirtschaft" => :agriculture,
        "Sonstige / Sonderobjekte" => :other,
        "Freizeitimmobilie gewerblich" => :recreational_property_business,
        "Zinshaus / Renditeobjekt" => :yield,
        "Parken" => :parking
      }.freeze

      private_constant :TRANSLATION_MAPPING

      property :id
      property :name,
        parse_filter: ->(fragment, **) { TRANSLATION_MAPPING[fragment] }

      collection_representer class: RealtyType
    end
  end
end
