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

    # @!group Instance Method Summary

    def to_a
      tmp = []
      tmp << :living if living?
      tmp << :business if business?
      tmp << :investment if investment?
      tmp
    end

    def map(&block)
      to_a.map(&block)
    end

    def translated
      map { |x| translate(x) }
    end

    def to_s
      translated.join(", ")
    end
  end
end
