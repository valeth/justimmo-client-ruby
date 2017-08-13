# frozen_string_literal: true

module JustimmoClient::V1
  class RealtyCategory < JustimmoBase
    attribute :id, Integer
    attribute :name
    attribute :sortablerank, Boolean
  end
end
