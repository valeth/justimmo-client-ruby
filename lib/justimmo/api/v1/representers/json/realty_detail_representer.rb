# frozen_string_literal: true

require "justimmo/api/v1/models/attachment"
require "justimmo/api/v1/models/contact"
require "justimmo/api/v1/models/location"
require "justimmo/api/v1/models/realty_category"
require_relative "justimmo_representer"
require_relative "attachment_representer"
require_relative "contact_representer"
require_relative "location_representer"
require_relative "realty_category_representer"

module Justimmo
  module V1
    module JSON
      class RealtyDetailRepresenter < JustimmoRepresenter
        property :category,
                 decorator: RealtyCategoryRepresenter,
                 class: RealtyCategory

        property :location,
                 decorator: LocationRepresenter,
                 class: Location

        property :contact,
                 decorator: ContactRepresenter,
                 class: Contact

        property :documents
        property :images360
        property :videos
        property :links

        property :title
        property :description
        property :description_furniture, type: Array
        property :furniture, type: Array

        %i[
          balcony_terrace_area balcony_area office_area garage_area garden_area
          total_area surface_area property_area basement_area storage_area
          loggia_area floor_area parking_area terrace_area buildable_area
          sales_area living_area
        ].each { |e| property e, type: Float }

        %i[
          store_rooms bathrooms balconies_terraces balconies gardens garages
          loggias basements toilet_rooms parking_spaces rooms
        ].each { |e| property e, type: Integer }

        property :available_from, type: DateTime
        property :status_id, type: Integer
        property :id, type: Integer
        property :number, type: Integer
        property :openimmo_id

        collection :attachments,
                   decorator: AttachmentRepresenter,
                   class: Attachment
      end
    end
  end
end
