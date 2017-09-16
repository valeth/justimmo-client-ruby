# frozen_string_literal: true

module JustimmoClient::V1
  class RealtyCategory < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,           Integer
    attribute :name,         String
    attribute :sortablerank, Boolean
  end
end
