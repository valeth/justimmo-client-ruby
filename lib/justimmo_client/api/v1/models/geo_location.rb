# frozen_string_literal: true

require "iso_country_codes"

module JustimmoClient::V1
  class GeoLocation < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :proximity,     String
    attribute :federal_state, String
    attribute :country,       String
    attribute :zip_code,      Integer
    attribute :latitude,      Float
    attribute :longitude,     Float
    attribute :location,      String
    attribute :proximity,     String
    attribute :floor,         Integer

    # @!group Instance Method Summary

    def country=(iso3_or_name)
      @country = IsoCountryCodes.find(iso3_or_name).name
    rescue IsoCountryCodes::UnknownCodeError
      @country = iso3_or_name
    end

    def floor=(flr)
      @floor = flr.to_i
    end

    def to_s
      ["#{zip_code} #{location}", federal_state, country].compact.join(", ")
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
