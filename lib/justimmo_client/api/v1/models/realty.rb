# frozen_string_literal: true

module JustimmoClient::V1
  class Realty < JustimmoBase
    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :id,                    Integer
    attribute :number,                Integer
    attribute :title,                 String, default: ""
    attribute :description,           String, default: ""
    attribute :teaser,                Array[String], default: []
    attribute :type_id,               Integer
    attribute :sub_type_id,           Integer
    attribute :status_id,             Integer
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
    attribute :contact,               Employee
    attribute :usage,                 RealtyUsage
    attribute :marketing,             RealtyMarketing
    attribute :geo,                   GeoLocation
    attribute :area,                  RealtyArea
    attribute :room_count,            RealtyRoomCount
    attribute :price,                 RealtyPrice

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
      log.debug("Failed to convert date: #{date}")
      @available = date
    end

    def description=(desc)
      @description =
        if @teaser.empty?
          parts = desc.partition("</ul>\n")
          self.teaser = parts[0..1].join
          parts.last
        else
          desc
        end
    end

    def teaser=(tea)
      @teaser =
        case tea
        when Array then tea
        when String then tea&.gsub(/<\/?(ul|li)>/, "")&.strip&.split("\n")
        else []
        end
    end

    def type
      @type ||= RealtyInterface.types.select { |x| x.id == type_id }.first
    end
  end
end
