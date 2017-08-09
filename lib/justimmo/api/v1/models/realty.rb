# frozen_string_literal: true

module Justimmo::V1
  class Realty < JustimmoBase
    attribute :id, Integer
    attribute :number, Integer

    attribute :title
    attribute :description
    attribute :status_id, Integer
    attribute :teaser
    attribute :proximity

    attribute :usage, RealtyUsage
    attribute :marketing, RealtyMarketing
    attribute :type_id, Integer
    attribute :sub_type_id, Integer

    attribute :geo, GeoLocation
    attribute :area, RealtyArea
    attribute :room_count, RealtyRoomCount
    attribute :floor
<<<<<<< HEAD
=======
    attribute :first_image
    attribute :second_image
>>>>>>> 01a1760... Move realty secions into or out of models.
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :openimmo_id
    attribute :available_from, DateTime
    attribute :contact, Employee
    attribute :description_furniture, Array[String]
    attribute :furniture, Array[String]
    attribute :documents
    attribute :videos
    attribute :images360
    attribute :links
<<<<<<< HEAD
    attribute :images, Array[Image]
=======
>>>>>>> 01a1760... Move realty secions into or out of models.
    def initialize(**options)
      super(options)
      @area = RealtyArea.new
      @room_count = RealtyRoomCount.new
      @geo = GeoLocation.new
    end
<<<<<<< HEAD
    def add_image(url, **options)
      @images ||= []
      image = Image.new
      image.add_url(url, options)
      @images << image
    end
=======
>>>>>>> 01a1760... Move realty secions into or out of models.
  end
end
