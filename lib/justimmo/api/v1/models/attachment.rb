# frozen_string_literal: true

module Justimmo::V1
  class Attachment < Base
    attr_accessor :category, :origin, :title, :format, :data

    def to_s
      data.to_s
    end

    def inspect
      "#<#{self.class.name} #{format} #{category}>"
    end
  end
end
