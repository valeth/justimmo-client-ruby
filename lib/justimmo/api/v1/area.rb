# frozen_string_literal: true

require 'justimmo/api/v1/realty_resource'

module Justimmo::API
  # Holds information about area size and count.
  class Area < RealtyResource
    def initialize(options = {})
      @attributes = %i[
        room_count living_area floor_area sales_area property_area surface_area
        total_area toilet_room_count bathroom_count store_room_count
        garden_area office_area storage_area cellar_area terrace_count
        terrace_area balcony_count balcony_area balcony_terrace_count
        balcony_terrace_area loggia_count loggia_area garage_count garage_area
        parking_count parking_area
      ]

      super(options) do |opts|
        yield(@attributes.keys, opts)
      end
    end

    def to_s
      @attributes[:room_count].to_s
    end

    def inspect
      "<Area: #{self}>"
    end
  end
end
