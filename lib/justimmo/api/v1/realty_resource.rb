# frozen_string_literal: true

require "justimmo/api/v1/resource"

module Justimmo::API
  class RealtyResource < Resource
    def self.query
      Justimmo::API::RealtyQuery
    end

    def mapper
      Mapper[:realty]
    end
  end
end
