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
      super(options)
      find_country(options[:name])
      find_country(options[:alpha3])
      find_country(options[:alpha2])
      @name   = @country&.name
      @alpha3 = @country&.alpha3
      @alpha2 = @country&.alpha2
    end

    def alpha2=(code)
      find_country(code)
      @alpha2 ||= @country&.alpha2
    end

    def alpha3=(code)
      find_country(code)
      @alpha3 ||= @country&.alpha3
    end

    def name=(country_name)
      find_country(country_name)
      @name ||= @country&.name
    end

    def to_s
      name
    end

    def to_h
      attributes
    end

    def to_json(options = nil)
      to_h.to_json(options)
    end

    alias as_json to_json

    def inspect
      "#<#{self.class} #{self}>"
    end

    private

    def find_country(name_or_code)
      return if name_or_code.nil?

      @country ||=
        if name_or_code.size <= 3
          IsoCountryCodes.find(name_or_code)
        else
          IsoCountryCodes.search_by_name(name_or_code).first
        end
    rescue IsoCountryCodes::UnknownCodeError
      nil
    end
  end
end
