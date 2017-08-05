# frozen_string_literal: true

module Justimmo::V1
  class Realty < JustimmoBase
    attribute :id, Integer
    attribute :number, Integer
    attribute :category, RealtyCategory
    attribute :title
    attribute :description
    attribute :status_id, Integer
    attribute :teaser
    attribute :proximity
    attribute :floor
    attribute :location
    attribute :zip_code, Integer
    attribute :federal_state
    attribute :country
    attribute :latitude, Float
    attribute :longitude, Float
    attribute :first_image
    attribute :second_image
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :openimmo_id
    attribute :available_from, DateTime
    attribute :contact, Employee
    attribute :attachments, Array[Attachment]
    attribute :description_furniture, Array[String]
    attribute :furniture, Array[String]
    attribute :documents
    attribute :videos
    attribute :images360
    attribute :links

    # Area
    attribute :balcony_terrace_area, Float
    attribute :balcony_area, Float
    attribute :office_area, Float
    attribute :garage_area, Float
    attribute :garden_area, Float
    attribute :total_area, Float
    attribute :surface_area, Float
    attribute :property_area, Float
    attribute :basement_area, Float
    attribute :storage_area, Float
    attribute :loggia_area, Float
    attribute :floor_area, Float
    attribute :parking_area, Float
    attribute :terrace_area, Float
    attribute :buildable_area, Float
    attribute :sales_area, Float
    attribute :living_area, Float

    # Room count
    attribute :store_rooms, Integer
    attribute :bathrooms, Integer
    attribute :balconies_terraces, Integer
    attribute :balconies, Integer
    attribute :gardens, Integer
    attribute :garages, Integer
    attribute :loggias, Integer
    attribute :basements, Integer
    attribute :toilet_rooms, Integer
    attribute :parking_spaces, Integer
    attribute :rooms, Integer
  end
end
