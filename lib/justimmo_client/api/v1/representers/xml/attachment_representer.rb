# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class AttachmentRepresenter < JustimmoRepresenter
      property :category,
        as: :gruppe,
        attribute: true,
        parse_filter: ->(fragment, _opt) do
          case fragment
          when "TITELBILD" then :title_image
          when "BILD" then :image
          else nil
          end
        end

      property :origin,
        as: :location,
        attribute: true,
        parse_filter: ->(fragment, _opt) { fragment.downcase }

      property :title, as: :anhangtitel

      nested :daten do
        property :url, as: :pfad
      end

      collection_representer class: Attachment
    end
  end
end
