# frozen_string_literal: true

module JustimmoClient::V1
  class Realty < JustimmoBase
    attribute :id, Integer
    attribute :number, Integer

    attribute :title
    attribute :description
    attribute :teaser

    attribute :usage, RealtyUsage
    attribute :marketing, RealtyMarketing
    attribute :type_id, Integer
    attribute :sub_type_id, Integer

    attribute :geo, GeoLocation
    attribute :area, RealtyArea
    attribute :room_count, RealtyRoomCount
    attribute :price, RealtyPrice
    attribute :status_id, Integer
    attribute :floor
    attribute :created_at, DateTime
    attribute :updated_at, DateTime
    attribute :openimmo_id
    attribute :contact, Employee
    attribute :description_furniture, Array[String]
    attribute :furniture, Array[String]

    attribute :images, Array[Image]
    attribute :documents, Array
    attribute :videos, Array
    attribute :images360, Array
    attribute :links, Array

    attribute :available, DateTime
    attribute :created_at, DateTime
    attribute :updated_at, DateTime

    def initialize(**options)
      super(options)
      @area = RealtyArea.new
      @room_count = RealtyRoomCount.new
      @geo = GeoLocation.new
    end

    # @param date [String]
    # @return [String, DateTime]
    def available=(date)
      @available = DateTime.parse(date)
    rescue ArgumentError
      log.error("Failed to convert date: #{date}")
      @available = date
    end

    def description=(desc)
      @description =
        if @teaser.nil?
          parts = desc.partition("</ul>\n")
          @teaser = parts[0..1].join
          parts.last
        else
          desc
        end
    end

    def add_image(url, **options)
      @images ||= []
      image = Image.new
      image.add_url(url, options)
      @images << image
    end

    def type
    end

    def sub_type
    end
  end
end
