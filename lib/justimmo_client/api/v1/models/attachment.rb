# frozen_string_literal: true

require "uri"

module JustimmoClient::V1
  class Attachment < JustimmoBase
    BASE_URL = "https://files.justimmo.at/public"

    private_constant :BASE_URL

    attribute :category, Symbol
    attribute :origin,   Symbol
    attribute :title,    String
    attribute :format,   String
    attribute :type,     String
    attribute :file,     String
    attribute :size,     Symbol

    # FIXME: the attachment can be something other than a image file
    #        maybe move type detection into representer?
    def url=(value)
      path = URI.parse(value).path.sub("/public/", "")
      @type, size, file = path.split("/")
      return if file.nil?
      @format ||= ::File.extname(file).tr(".", "")
      @file = ::File.basename(file, ".#{@format}")
      @size = size.start_with?("user") ? :user_big : :big
    end

    def url(size = nil)
      size ||= @size
      "#{BASE_URL}/#{@type}/#{size}/#{file}.#{format}"
    end

    alias to_s url
    alias [] url

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
