# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class AttachmentImageRepresenter < JustimmoRepresenter
      property :small
      property :small2
      property :medium
      property :medium2
      property :big
      property :big2
      property :fullhd
      property :path
    end
  end
end
