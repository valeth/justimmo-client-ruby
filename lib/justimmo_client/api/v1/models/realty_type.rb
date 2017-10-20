# frozen_string_literal: true

module JustimmoClient::V1
  class RealtyType < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,   Integer
    attribute :name, Symbol

    def translated
      translate("types.#{@name}")
    end

    def to_s
      translated
    end
  end
end
