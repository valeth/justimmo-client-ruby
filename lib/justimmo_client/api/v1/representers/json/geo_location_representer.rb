# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class GeoLocationRepresenter < JustimmoRepresenter
      property :zip_code
      property :location
      property :federal_state
      property :floor
      property :country
      property :latitude
      property :longitude
    end
  end
end
