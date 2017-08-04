# frozen_string_literal: true

module Justimmo::V1
  module XML
    class AttachmentImageRepresenter < JustimmoRepresenter
      property :small
      property :small2, as: :s220x155
      property :medium
      property :medium2
      property :big
      property :big2
      property :fullhd
      property :path, as: :pfad
    end
  end
end
