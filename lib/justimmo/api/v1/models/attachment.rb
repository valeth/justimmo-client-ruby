# frozen_string_literal: true

module Justimmo::V1
  class Attachment < JustimmoBase
    attribute :category
    attribute :origin
    attribute :title
    attribute :format
    attribute :data, AttachmentImage

    def to_s
      data.to_s
    end

    def inspect
      "#<#{self.class.name} #{format} #{category}>"
    end
  end
end
