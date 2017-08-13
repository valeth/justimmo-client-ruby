# frozen_string_literal: true

module Justimmo::V1
  class RealtyCategory < JustimmoBase
    attribute :id, Integer
    attribute :name
    attribute :sortablerank, Boolean
  end
end
