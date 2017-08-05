# frozen_string_literal: true

module Justimmo::V1
  class RealtyCategory < JustimmoBase
    attribute :usage, RealtyUsage
    attribute :marketing, RealtyMarketing
    attribute :type_id, Integer
    attribute :sub_type_id, Integer
  end
end
