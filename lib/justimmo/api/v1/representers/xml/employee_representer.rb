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
        class: Image do
          %i[small medium big].each do |size|
            property size, setter: ->(represented:, fragment:, **) { represented.add_url(fragment, default: :user_big) }
          end
        end

      # NOTE: Just contains the picture again
      #       Comment it out for now in case we still need it later.
      #
      # nested :user_defined_anyfield do
      #   property :attachment,
      #     as: :anhang,
      #     class: Image do
      #       property :category, as: :gruppe, attribute: true
      #       property :origin, as: :location, attribute: true
      #       property :title, as: :anhangtitel
      #       nested :daten do
      #         property :path, as: :pfad, setter: ->(represented:, fragment:, **) { represented.add_url(fragment, default: :user_big) }
      #       end
      #     end
      # end
    end
  end
end
