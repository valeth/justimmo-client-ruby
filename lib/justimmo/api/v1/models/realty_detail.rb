# frozen_string_literal: true

require_relative "base"

module Justimmo
  module V1
    class RealtyDetail < Base
      attr_accessor :id, :number, :openimmo_id, :status_id, :available_from,
                    :contact, :area, :category, :location, :attachments,
                    :title, :description, :description_furniture, :furniture,
                    :documents, :videos, :images360, :links

      # Area
      attr_accessor :balcony_terrace_area, :balcony_area, :office_area,
        :garage_area, :garden_area, :total_area, :surface_area, :property_area,
        :basement_area, :storage_area, :loggia_area, :floor_area, :parking_area,
        :terrace_area, :buildable_area, :sales_area, :living_area

      # Room count
      attr_accessor :store_rooms, :bathrooms, :balconies_terraces, :balconies,
        :gardens, :garages, :loggias, :basements, :toilet_rooms,
        :parking_spaces, :rooms
    end
  end
end
