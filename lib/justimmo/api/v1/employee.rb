# frozen_string_literal: true

require "justimmo/parser"
require "justimmo/api/v1/mapper"

module Justimmo::API
  # Holds employee contact information.
  # @!attribute [r] id
  #   @return [Integer]
  # @!attribute [r] email
  #   @return [String]
  # @!attribute [r] phone
  #   @return [String]
  # @!attribute [r] last_name
  #   @return [String]
  # @!attribute [r] first_name
  #   @return [String]
  # @!attribute [r] title
  #   @return [String]
  # @!attribute [r] salutation
  #   @return [String]
  # @!attribute [r] company
  #   @return [String]
  # @!attribute [r] street
  #   @return [String]
  # @!attribute [r] zip_code
  #   @return [Integer]
  # @!attribute [r] location
  #   @return [String]
  # @!attribute [r] feedback
  #   @return [String]
  # @!attribute [r] url
  #   @return [String]
  # @!attribute [r] personal_number
  #   @return [Integer]
  class Employee < Resource
    class << self
      def list
        from_xml(query.list)
      end

      def detail(id)
        from_xml(query.detail(id))
      end

      def ids
        query.ids
      end

      def from_xml(data)
        tmp = super(data)
        # Fetch array when generating from listing.
        tmp = tmp.dig(:justimmo, :kategorie, :mitarbeiter)
        # Otherwise we just need the root element.
        tmp ||= tmp&.dig(:justimmo) || {}
        case tmp
        when Array then tmp.map { |x| new(x) }
        when Hash  then new(tmp)
        end
      end

      def query
        Justimmo::API::EmployeeQuery
      end
    end

    def initialize(options = {})
      @attributes = %i[
        id email phone last_name first_name title salutation company street
        zip_code location feedback url personal_number
        user_defined_anyfield
      ]

      super(options) do |opts|
        user_image(opts)
      end
    end

    def to_s
      @attributes[:id].to_s
    end

    def inspect
      "<Employee: #{self}>"
    end

    # Get the user image in JPG format.
    # @param size [Symbol] The image size.
    # @return [String, nil]
    #   The image url or nil if no image with this size is available.
    def image(size = :medium)
      @attributes.dig(:image_paths, size)
    end

    private

    def user_image(options)
      return if options[:image_paths]
      options[:image_paths] = {}
      options[:image]&.each do |key, value|
        match = /path_?(?<size>.*)/.match(key)
        if match
          size = (match[:size].empty? ? :small : match[:size].to_sym)
          options[:image_paths][size] = value
        else
          options[:image_paths][key] = value
        end
      end

      options.delete(:image)
    end

    def mapper
      Mapper[:employee]
    end
  end
end
