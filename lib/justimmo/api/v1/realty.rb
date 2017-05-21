# frozen_string_literal: true

require 'justimmo/parser'

module Justimmo::API
  # Represents a complete realty resource.
  class Realty < Resource
    # Subsections that will pull in data from the Realty object.
    SECTIONS = %i[category prices areas geo management attachments contact].freeze

    # Subsections that will be merged into the Realty object.
    MERGE = %i[technical free_text].freeze

    private_constant :SECTIONS, :MERGE

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
      MERGE.each { |x| merge_section(x, options) }

      super(options)
    end

    def to_s
      @attributes[:id].to_s
    end

    def inspect
      "<Realty: #{self}>"
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
      data = [data[:attachment]].flatten if section == :attachments && data.is_a?(Hash)

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
      def from_xml(xml)
        parsed = Justimmo::Parser.parse(xml, mapper)
        parsed = parsed.dig(:justimmo, :realty) || {}
        case parsed
        when Array then parsed.map { |x| new(x) }
        when Hash  then new(parsed)
        end
      end

      # @param params [Hash]
      # @return [Array<Realty>] Array of Realty objects or empty Array
      def list(params = {})
        from_xml(query.list(params))
      end

      # @param params [Hash]
      # @return [Realty] The Realty object.
      def detail(params = {})
        from_xml(query.detail(params))
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
