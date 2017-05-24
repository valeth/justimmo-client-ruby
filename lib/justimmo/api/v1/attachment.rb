# frozen_string_literal: true

require 'justimmo/api/v1/resource'

module Justimmo::API
  # An attachment, like images etc.
  class Attachment < Resource
    def initialize(options = {})
      @attributes = %i[group location format data]

      super(options) do |opts|
        unprefix_attributes(opts)
      end
    end

    def to_s
      attachment_title
    end

    alias title to_s

    def inspect
      "<Attachment: '#{self}'>"
    end

    private

    def mapper
      Mapper.create
    end

    def unprefix_attributes(hash)
      hash&.transform_keys! do |key|
        key.to_s.sub(/^@/, '').to_sym
      end
    end
  end
end
