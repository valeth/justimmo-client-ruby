# frozen_string_literal: true

require 'justimmo/api/v1/resource'
require 'justimmo/api/v1/realty/realty_area'
require 'justimmo/api/v1/realty/realty_attachment'
require 'justimmo/api/v1/realty/realty_category'
require 'justimmo/api/v1/realty/realty_contact'
require 'justimmo/api/v1/realty/realty_geo'
require 'justimmo/api/v1/realty/realty_management'
require 'justimmo/api/v1/realty/realty_price'

module Justimmo::API
  # Represents a complete realty resource.
  class Realty < Resource
    SECTIONS = %i[
      category prices areas geo
      management attachments contact
    ].freeze

    MERGE = %i[
      technical
      free_text
    ].freeze

    def initialize(options = {})
      @attributes = %i[
        id external_id
        title description
        openimmo_obid language
        teaser proximity
        first_image second_image
        created_at updated_at
      ] + SECTIONS

      SECTIONS.each { |x| options[x] = build_section(x, options) }
      MERGE.each { |x| }

      super(options)
    end

    def property_number
      external_id
    end

    def description
      @attributes[:free_text].description
    end

    def title
      @attributes[:free_text].title
    end

    private

    def build_section(section, options)
      klass = "Justimmo::API::Realty#{section.to_s.classify}".constantize
      data = options.delete(section) || {}
      data = [data[:attachment]].flatten if section == :attachments

      if data.is_a?(Array)
        data.compact.map { |x| build_sub_class(klass, x, options) }
      else
        build_sub_class(klass, data, options)
      end
    end

    def build_sub_class(klass, data, options)
      klass.new(data) do |opts|
        opts.each do |key, _value|
          next if @attributes.include?(key) # we still need this key
          new_value = options.delete(key)
          opts[key] = new_value unless new_value.nil?
        end
      end
    end

    def merge_section(section, options)
      return unless options.key?(section)
      data = options.delete(section)
      options.update(data)
    end

    class << self
      # @param params [Hash]
      # @return [Array<Realty>] Array of Realty objects or empty Array
      def list(params = {})
        response = query.list(params)
        response.map do |options|
          new(options)
        end
      end

      # @param params [Hash]
      # @return [Realty] The Realty object.
      def detail(params = {})
        response = query.detail(params)
        new(response)
      end

      def expose(params = {})
        query.expose(params)
      end

      def inquiry(params = {})
        query.inquiry(params)
      end

      def ids(params = {})
        query.ids(params)
      end
    end
  end
end
