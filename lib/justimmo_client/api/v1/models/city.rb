# frozen_string_literal: true

module JustimmoClient::V1
  class City < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,               Integer
    attribute :country_id,       Integer
    attribute :region_id,        Integer
    attribute :zip_code,         Integer
    attribute :location,         String
    attribute :federal_state_id, Integer
  end
end
