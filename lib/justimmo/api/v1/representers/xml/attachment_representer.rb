# frozen_string_literal: true

require "justimmo/api/v1/models/attachment_image"
require_relative "justimmo_representer"
require_relative "attachment_image_representer"

module Justimmo
  module V1
    module XML
      class AttachmentRepresenter < JustimmoRepresenter
        property :category, as: :gruppe, attribute: true
        property :origin, as: :location, attribute: true
        property :title, as: :anhangtitel
        property :format
        property :data,
                 as: :daten,
                 decorator: AttachmentImageRepresenter,
                 class: AttachmentImage
      end
    end
  end
end
