# frozen_string_literal: true

module Justimmo::V1
  class Location < Base
    attr_accessor :zip_code, :location, :federal_state, :country, :latitude, :longitude
  end
end
