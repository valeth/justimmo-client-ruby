# frozen_string_literal: true

module Justimmo::Client::V1
  module JSON
    class LocationRepresenter < JustimmoRepresenter
      property :zip_code
      property :location
      property :federal_state
      property :country
      property :latitude
      property :longitude
    end
  end
end
