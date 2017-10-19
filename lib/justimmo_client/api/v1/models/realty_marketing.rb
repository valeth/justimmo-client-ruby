# frozen_string_literal: true

module JustimmoClient::V1
  class RealtyMarketing < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :buy,  Boolean
    attribute :rent, Boolean

    # @!group Instance Method Summary

    def to_a
      tmp = []
      tmp << :buy if buy?
      tmp << :rent if rent?
      tmp
    end

    def to_s
      to_a.join(", ")
    end

    def map(&block)
      to_a.map(&block)
    end
  end
end
