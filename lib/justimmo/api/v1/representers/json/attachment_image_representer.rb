# frozen_string_literal: true

require_relative 'justimmo_representer'

module Justimmo
  module V1
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
end
