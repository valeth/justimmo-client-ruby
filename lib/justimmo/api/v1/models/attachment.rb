# frozen_string_literal: true

require_relative "base"

module Justimmo
  module V1
    class Attachment < Base
      attr_accessor :category, :origin, :title, :format, :data

      def to_s
        data.to_s
      end
    end
  end
end
