# frozen_string_literal: true

require "justimmo/api/v1/models/attachment_image"
require_relative "justimmo_representer"
require_relative "attachment_image_representer"

module Justimmo
  module V1
    module JSON
      class ContactRepresenter < JustimmoRepresenter
        property :id, type: Integer
        property :number, type: Integer
        property :last_name
        property :first_name
        property :phone
        property :phone_mobile
        property :salutation
        property :email
        property :email_feedback
        property :company
        property :street
        property :zip_code, type: Integer
        property :location
        property :website

        property :picture,
                 decorator: AttachmentImageRepresenter,
                 class: AttachmentImage

        property :attachment,
                 decorator: AttachmentRepresenter,
                 class: Attachment
      end
    end
  end
end
