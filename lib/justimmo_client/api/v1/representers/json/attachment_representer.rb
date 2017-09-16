# frozen_string_literal: true

module JustimmoClient::V1
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
