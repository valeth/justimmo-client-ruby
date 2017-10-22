# frozen_string_literal: true

require "iso_country_codes"

module JustimmoClient::V1
  class Country < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,     Integer
    attribute :alpha2, String, default: ""
    attribute :alpha3, String, default: ""
    attribute :name,   String, default: ""

    # @!group Instance Method Summary

    def initialize(**options)
      @country = find_country(options[:name])
      return unless @country
      options.update(name: @country.name, alpha2: @country.alpha2, alpha3: @country.alpha3)
      super(options)
    end

    def alpha2=(code)
      @alpha2 ||= @country.alpha2
    end

    def alpha3=(code)
      @alpha3 ||= @country.alpha3
    end

    def to_s
      name
    end

    def inspect
      "#<#{self.class} #{self}>"
    end

    private

    def find_country(name_or_code)
      if name_or_code.size <= 3
        IsoCountryCodes.find(name_or_code)
      else
        IsoCountryCodes.search_by_name(name_or_code)
      end
    rescue IsoCountryCodes::UnknownCodeError
      nil
    end
  end
end
