# frozen_string_literal: true

require_relative "justimmo_representer"

module Justimmo
  module V1
    module JSON
      class LocationRepresenter < JustimmoRepresenter
        property :zip_code
        property :location
        property :federal_state
        property :country
        property :latitude, type: Float
        property :longitude, type: Float
      end
    end
  end
end
