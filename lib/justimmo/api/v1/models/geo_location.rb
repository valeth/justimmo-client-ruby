# frozen_string_literal: true

require "iso_country_codes"

module Justimmo::V1
  class GeoLocation < JustimmoBase
    attribute :proximity
    attribute :federal_state
    attribute :country
    attribute :zip_code, Integer
    attribute :latitude, Float
    attribute :longitude, Float
    attribute :location
    attribute :proximity
    attribute :floor, Integer

    def country=(iso3)
      @country = IsoCountryCodes.find(iso3)
    end

    def floor=(flr)
      @floor = flr.to_i
    end

    def to_s
      ["#{zip_code} #{location}", federal_state, country&.name].compact.join(", ")
    end

    def inspect
      "#<#{self.class} #{self}>"
    end

    def to_h
      { latitude: latitude, longitude: longitude }
    end

    def to_a
      [latitude, longitude]
    end
  end
end
