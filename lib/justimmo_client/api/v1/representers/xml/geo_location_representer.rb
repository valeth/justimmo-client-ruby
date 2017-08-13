# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class GeoLocationRepresenter < JustimmoRepresenter
      property :zip_code, as: :plz
      property :location, as: :ort
      property :federal_state, as: :bundesland
      property :floor, as: :etage

      nested :land do
        property :country, as: :iso_land, attribute: true
      end

      property :latitude,
        as: :user_defined_simplefield,
        parse_filter: ->(_fragment, options) { options[:doc].css("user_defined_simplefield[feldname=geokoordinaten_breitengrad_exakt]").text }

      property :longitude,
        as: :user_defined_simplefield,
        parse_filter: ->(_fragment, options) { options[:doc].css("user_defined_simplefield[feldname=geokoordinaten_laengengrad_exakt]").text }
    end
  end
end
