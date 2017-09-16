# frozen_string_literal: true

module JustimmoClient::V1
  class FederalState < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,         Integer
    attribute :name,       String
    attribute :country_id, Integer
    attribute :fips,       String
    attribute :iso,        String
  end
end
