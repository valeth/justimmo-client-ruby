# frozen_string_literal: true

module Justimmo::V1
  module XML
    class EmployeeRepresenter < JustimmoRepresenter
      property :id, type: Integer
      property :number,       as: :personennummer, type: Integer
      property :last_name,    as: :name
      property :first_name,   as: :vorname
      property :phone,        as: :tel_zentrale
      property :phone_mobile, as: :tel_handy
      property :salutation,   as: :anrede
      property :email,        as: :email_direkt
      property :email_feedback
      property :company,      as: :firma
      property :street,       as: :strasse
      property :zip_code,     as: :plz, type: Integer
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
