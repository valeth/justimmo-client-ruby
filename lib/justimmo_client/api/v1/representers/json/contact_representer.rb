# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class ContactRepresenter < JustimmoRepresenter
      property :id
      property :number
      property :last_name
      property :first_name
      property :phone
      property :phone_mobile
      property :salutation
      property :email
      property :email_feedback
      property :company
      property :street
      property :zip_code
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
