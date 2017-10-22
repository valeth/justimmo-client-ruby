# frozen_string_literal: true

module JustimmoClient::V1
  class Realty < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,                    Integer
    attribute :number,                Integer
    attribute :title,                 String
    attribute :description,           String, default: ""
    attribute :teaser,                String, default: ""
    attribute :usage,                 RealtyUsage
    attribute :marketing,             RealtyMarketing
    attribute :type_id,               Integer
    attribute :sub_type_id,           Integer
    attribute :geo,                   GeoLocation
    attribute :area,                  RealtyArea
    attribute :room_count,            RealtyRoomCount
    attribute :price,                 RealtyPrice
    attribute :status_id,             Integer
    attribute :floor,                 String
    attribute :openimmo_id,           String
    attribute :description_furniture, Array[String], default: []
    attribute :furniture,             Array[String], default: []
    attribute :attachments,           Array[Attachment], default: []
    attribute :documents,             Array, default: []
    attribute :videos,                Array, default: []
    attribute :images360,             Array, default: []
    attribute :links,                 Array, default: []
    attribute :construction_year,     Integer
    attribute :available,             DateTime
    attribute :created_at,            DateTime
    attribute :updated_at,            DateTime

    # @!group Instance Method Summary

    def images
      attachments.select { |x| x.type == "pic" }
    end

    def title_image
      attachments.select { |x| x.category == :title_image }.first
    end

    # @param date [String]
    # @return [String, DateTime]
    def available=(date)
      @available = DateTime.parse(date) unless date.nil?
    rescue ArgumentError
      log.error("Failed to convert date: #{date}")
      @available = date
    end

    def description=(desc)
      @description =
        if @teaser.empty?
          parts = desc.partition("</ul>\n")
          @teaser = parts[0..1].join
          parts.last.empty? ? @teaser : parts.last
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
