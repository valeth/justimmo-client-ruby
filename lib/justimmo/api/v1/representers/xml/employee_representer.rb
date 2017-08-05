# frozen_string_literal: true

module Justimmo::V1
  module XML
    class EmployeeRepresenter < JustimmoRepresenter
      property :id
      property :email_feedback
      property :number,       as: :personennummer
      property :last_name,    as: :name
      property :first_name,   as: :vorname
      property :phone,        as: :tel_zentrale
      property :phone_mobile, as: :tel_handy
      property :salutation,   as: :anrede
      property :email,        as: :email_direkt
      property :company,      as: :firma
      property :street,       as: :strasse
      property :zip_code,     as: :plz
      property :location,     as: :ort
      property :website,      as: :url

      property :picture,
        as: :bild,
        decorator: AttachmentImageRepresenter,
        class: AttachmentImage

      nested :user_defined_anyfield do
        property :attachment,
          as: :anhang,
          decorator: AttachmentRepresenter,
          class: Attachment
      end
    end
  end
end
