# frozen_string_literal: true

module Justimmo::V1
  class Realty < Base
    attr_accessor :id, :number, :category, :title, :description, :status_id,
      :teaser, :proximity, :floor, :location, :zip_code, :federal_state,
      :country, :latitude, :longitude, :first_image, :second_image,
      :created_at, :updated_at, :openimmo_id, :available_from,
      :contact, :attachments, :description_furniture, :furniture,
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
