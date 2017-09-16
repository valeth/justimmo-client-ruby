# frozen_string_literal: true

module JustimmoClient::V1
  class File < JustimmoBase
    BASE_URL = "https://files.justimmo.at/public"

    # @!group Attributes

    # @!macro [attach] attribute
    #   @return [$2]
    attribute :title,    String
    attribute :category, Symbol
    attribute :origin,   Symbol
    attribute :type,     Symbol
    attribute :name,     String
    attribute :format,   String

    # @!group Instance Method Summary

    def initialize(**options)
      super(options)
      @settings = []
    end

    def category=(cat)
      @category =
        case cat
        when "BILD" then :image
        when "TITELBILD" then :title_image
        else nil
        end
    end

    def origin=(orig)
      @origin = orig&.downcase&.to_sym
    end

    def get(setting = nil)
      return nil if @default.nil? || @settings.empty?
      setting = (@settings.include?(setting) ? setting : @default)
      "#{BASE_URL}/#{@type}/#{setting}/#{@name}"
    end

    alias [] get

    def add_url(url, default: nil)
      uri_path = URI.parse(url).path
      @name ||= ::File.basename(uri_path)
      @format ||= ::File.extname(@name)
      @settings << ::URI.parse(url).path.split("/")[-2].to_sym
      @default = default || @settings.last
    end

    alias path= add_url

    def to_s
      get
    end

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
