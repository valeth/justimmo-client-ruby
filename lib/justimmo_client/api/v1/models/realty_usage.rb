# frozen_string_literal: true
module JustimmoClient::V1
  class RealtyUsage < JustimmoBase
    # @!group Attributes

    # @!method living?
    #   @api private
    #   @return [Boolean]

    # @!method business?
    #   @api private
    #   @return [Boolean]

    # @!method investment?
    #   @api private
    #   @return [Boolean]

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :living,     Boolean
    attribute :business,   Boolean
    attribute :investment, Boolean
  end
end
