# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyRepresenter < JustimmoRepresenter
      property :usage, class: RealtyUsage do
        property :living
        property :business
        property :investment
      end
      property :marketing, class: RealtyMarketing do
        property :buy
        property :rent
      end
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
      property :floor
      property :area,
               decorator: RealtyAreaRepresenter,
               class: RealtyArea
      property :geo,
        decorator: GeoLocationRepresenter,
        class: GeoLocation
      property :room_count,
        decorator: RealtyRoomCountRepresenter,
        class: RealtyRoomCount

      property :openimmo_id
      property :available
      property :construction_year
      property :contact,
               decorator: ContactRepresenter,
               class: Employee
      property :description_furniture
      property :furniture
      property :price,
        decorator: RealtyPriceRepresenter,
        class: RealtyPrice
      collection :images, class: Image do
        property :category
        property :origin
        property :title
        %i[pfad small medium big2 medium2 s220x155 fullhd].each do |size|
          property size,
            setter: ->(represented:, fragment:, **) { represented.add_url(fragment, default: :big) },
            getter: ->(represented:, **) { represented[size] }
        end
      end
      property :documents
      property :images360
      property :videos
      property :links

      collection_representer class: Realty
    end
  end
end
