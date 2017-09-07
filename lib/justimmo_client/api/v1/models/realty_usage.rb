# frozen_string_literal: true
module JustimmoClient::V1
  class RealtyUsage < JustimmoBase
    attribute :living, Boolean
    attribute :business, Boolean
    attribute :investment, Boolean
  end
end
