# frozen_string_literal: true

require "iso_country_codes"

module JustimmoClient::V1
  class Country < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,     Integer
    attribute :alpha2, String
    attribute :alpha2, String

    # @!group Instance Method Summary

    def initialize(**options)
      super(options)
      @country = nil
    end

    def alpha2=(code)
      @country ||= IsoCountryCodes.find(code)
      @alpha2 ||= @country.alpha2
    end

    def alpha3=(code)
      @country ||= IsoCountryCodes.find(code)
      @alpha3 ||= @country.alpha3
    end

    def name
      @country&.name
    end

    def to_s
      @country&.name || ""
    end

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
