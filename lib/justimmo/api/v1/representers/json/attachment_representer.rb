# frozen_string_literal: true

require "justimmo/api/v1/models/attachment_image"
require_relative "justimmo_representer"
require_relative "attachment_image_representer"

module Justimmo
  module V1
    module JSON
      class AttachmentRepresenter < JustimmoRepresenter
        property :category
        property :origin
        property :title
        property :format
        property :data,
                 decorator: AttachmentImageRepresenter,
                 class: AttachmentImage
      end
    end
  end
end
