# frozen_string_literal: true

module Justimmo::V1
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
