# frozen_string_literal: true

require "iso_country_codes"

module Justimmo::V1
  class Country < JustimmoBase
    attribute :id, Integer
    attribute :alpha2
    attribute :alpha2

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
