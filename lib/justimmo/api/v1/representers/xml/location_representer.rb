# frozen_string_literal: true

require_relative "justimmo_representer"

module Justimmo
  module V1
    module XML
      class LocationRepresenter < JustimmoRepresenter
        property :zip_code, as: :plz
        property :location, as: :ort
        property :federal_state, as: :bundesland
        nested :land do
          property :country, as: :iso_land, attribute: true
        end

        latitude_filter = lambda do |_fragment, options|
          options[:doc].css("user_defined_simplefield[feldname=geokoordinaten_breitengrad_exakt]").text
        end

        property :latitude,
                 as: :user_defined_simplefield,
                 parse_filter: latitude_filter,
                 type: Float

        longitude_filter = lambda do |_fragment, options|
          options[:doc].css("user_defined_simplefield[feldname=geokoordinaten_laengengrad_exakt]").text
        end

        property :longitude,
                 as: :user_defined_simplefield,
                 parse_filter: longitude_filter,
                 type: Float
      end
    end
  end
end
