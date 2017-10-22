# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class EmployeeRepresenter < JustimmoRepresenter
      property :id
      property :number,       as: :personennummer
      property :first_name,   as: :vorname
      property :last_name,    as: :nachname
      property :salutation,   as: :titel
      property :position
      property :phone,        as: :tel
      property :mobile,       as: :handy
      property :fax
      property :email
      property :street,       as: :strasse
      property :zip_code,     as: :plz
      property :location,     as: :ort
      property :website,      as: :url

      collection :attachments,
        as: :anhang,
        wrap: :anhaenge,
        decorator: AttachmentRepresenter,
        class: Attachment

      nested :bild do
        property :pfad,
          setter: ->(fragment:, represented:, **) do
            represented.attachments << Attachment.new(url: fragment)
          end
      end
    end
  end
end
