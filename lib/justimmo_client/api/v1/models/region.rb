# frozen_string_literal: true

module JustimmoClient::V1
  class Region < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,   Integer
    attribute :name, String
  end
end
