# frozen_string_literal: true

module Justimmo::V1
  class AttachmentImage < JustimmoBase
    attribute :small
    attribute :small2
    attribute :medium
    attribute :medium2
    attribute :big
    attribute :big2
    attribute :fullhd

    def path=(arg)
      @big = arg
    end

    def to_s
      big
    end
  end
end
