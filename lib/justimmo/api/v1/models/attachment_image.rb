# frozen_string_literal: true

require_relative "base"

module Justimmo
  module V1
    class AttachmentImage < Base
      attr_accessor :small, :small2, :medium, :medium2, :big, :big2, :fullhd, :path

      def to_s
        big || path
      end
    end
  end
end
