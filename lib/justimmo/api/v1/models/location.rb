# frozen_string_literal: true

require_relative "base"

module Justimmo
  module V1
    class Location < Base
      attr_accessor :zip_code, :location, :federal_state, :country, :latitude, :longitude
    end
  end
end
