# frozen_string_literal: true

module JustimmoClient::V1
  class RealtyMarketing < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :buy,  Boolean
    attribute :rent, Boolean
  end
end
