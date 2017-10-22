# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyRepresenter < JustimmoRepresenter
      property :type_id
      property :sub_type_id
      property :id
      property :number
      property :created_at
      property :updated_at
      property :status_id
      property :title
      property :teaser
      property :description
      property :openimmo_id
      property :available
      property :construction_year
      property :description_furniture
      property :furniture
      property :documents
      property :images360
      property :videos
      property :links

      property :usage, class: RealtyUsage do
        property :living
        property :business
        property :investment
      end

      property :marketing, class: RealtyMarketing do
        property :buy
        property :rent
      end

      property :area, class: RealtyArea do
        property :balcony_terrace
        property :balcony
        property :office
        property :garage
        property :garden
        property :total
        property :surface
        property :property
        property :basement
        property :storage
        property :loggia
        property :floor
        property :parking
        property :terrace
        property :buildable
        property :sales
        property :living
      end

      property :geo, class: GeoLocation do
        property :zip_code
        property :location
        property :federal_state
        property :floor
        property :country
        property :latitude
        property :longitude
      end

      property :room_count, class: RealtyRoomCount do
        property :store
        property :bathroom
        property :balcony_terrace
        property :balcony
        property :garden
        property :garage
        property :loggia
        property :basement
        property :toilet
        property :parking_space
        property :total
      end

      property :contact, decorator: EmployeeRepresenter, class: Employee do
        property :email_feedback
        property :email
        property :last_name
        property :company
        property :salutation
        property :phone
        property :mobile
      end

      property :price, class: RealtyPrice do
        property :purcase
        property :purcase_net
        property :rent
        property :rent_net
        property :rent_cold
        property :rent_including_heating
        property :deposit
        property :rent_per_sqm
        property :operating_cost
        property :operating_cost_net
        property :operating_cost_per_sqm
        property :currency
        property :commission
        property :rent_vat
        property :provision
        property :including_vat
        property :on_demand
        property :real_estate_taxes
        property :land_registry
        property :operating_cost_vat
      end

      collection :attachments,
        decorator: AttachmentRepresenter,
        class: Attachment

      collection_representer class: Realty
    end
  end
end
