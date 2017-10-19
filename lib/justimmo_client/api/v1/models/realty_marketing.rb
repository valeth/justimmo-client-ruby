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
