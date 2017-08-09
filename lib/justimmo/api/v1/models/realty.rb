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
    attribute :images, Array[Image]
    def initialize(**options)
      super(options)
      @area = RealtyArea.new
      @room_count = RealtyRoomCount.new
      @geo = GeoLocation.new
    end
    def add_image(url, **options)
      @images ||= []
      image = Image.new
      image.add_url(url, options)
      @images << image
    end
  end
end
