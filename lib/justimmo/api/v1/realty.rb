# frozen_string_literal: true

require 'active_support/core_ext/hash/transform_values'
require 'justimmo/parser'
require 'justimmo/api/v1/realty_resource'

module Justimmo::API
  # Represents a complete realty resource.
  # @!attribute [r] id
  #   @return [Integer]
  # @!attribute [r] external_id
  #   @return [Integer]
  # @!attribute [r] title
  #   @return [String]
  # @!attribute [r] description
  #   @return [String]
  # @!attribute [r] openimmo_object_id
  #   @return [Integer]
  # @!attribute [r] language
  #   @return [String]
  # @!attribute [r] teaser
  #   @return [String]
  # @!attribute [r] proximity
  #   @return [String]
  # @!attribute [r] first_image
  #   @return [String]
  # @!attribute [r] second_image
  #   @return [String]
  # @!attribute [r] created_at
  #   @return [DateTime]
  # @!attribute [r] updated_at
  #   @return [DateTime]
  # @!attribute [r] category
  #   @return [RealtyCategory]
  # @!attribute [r] prices
  #   @return [RealtyPrice]
  # @!attribute [r] areas
  #   @return [RealtyArea]
  # @!attribute [r] geo
  #   @return [RealtyGeo]
  # @!attribute [r] management
  #   @return [RealtyManagement]
  # @!attribute [r] contact
  #   @return [Employee]
  class Realty < RealtyResource
    class << self
      # @param (see RealtyQuery.list)
      # @option (see RealtyQuery.list)
      # @return [Array<Realty>] An array of realty objects.
      def list(params = {})
        from_xml(query.list(params))
      end

      # Get detailed information about a single realty.
      # @param (see RealtyQuery.detail)
      # @option (see RealtyQuery.detail)
      # @return [Realty] The Realty object.
      def detail(id, params = {})
        from_xml(query.detail(id, params))
      end

      # @param (see RealtyQuery.expose)
      # @option (see RealtyQuery.expose)
      # @return (see RealtyQuery.expose)
      def expose(params = {})
        query.expose(params)
      end

      # @param (see RealtyQuery.inquiry)
      # @option (see RealtyQuery.inquiry)
      # @return (see RealtyQuery.inquiry)
      def inquiry(params = {})
        query.inquiry(params)
      end

      # @param (see RealtyQuery.ids)
      # @option (see RealtyQuery.ids)
      # @return (see RealtyQuery.ids)
      def ids(params = {})
        query.ids(params)
      end

      # Create a new realty object from XML data.
      # @param data [String] The XML string.
      # @return [Realty, Array<Realty>]
      def from_xml(data)
        tmp = super(data).dig(:justimmo, :immobilie) || {}
        case tmp
        when Array then tmp.map { |x| new(x) }
        when Hash  then new(tmp)
        end
      end
    end

    def initialize(options = {})
      @attributes = %i[
        id external_id openimmo_object_id
        title description
        zip_code location federal_state country latitude longitude
        usage marketing_type type_id sub_type_id
        language teaser proximity
        first_image second_image
        created_at updated_at
        prices areas contact attachments
      ]

      super(options) do |opts|
        process_merged(opts)
        process_sections(opts)
        sanitize(opts)
      end
    end

    def to_s
      @attributes[:id].to_s
    end

    def inspect
      "<Realty: #{self}>"
    end

    def purcase?
      @attributes.dig(:marketing_type, :purcase) || false
    end

    def rent?
      @attributes.dig(:marketing_type, :rent) || false
    end

    def living?
      @attributes.dig(:usage, :living) || false
    end

    def business?
      @attributes.dig(:usage, :business) || false
    end

    def investment?
      @attributes.dig(:usage, :investment) || false
    end

    private

    # merge
    def process_merged(options)
      process_category(options)
      process_geo(options)
      process_management(options)
      process_technical(options)
      process_free_text(options)
    end

    def process_category(options)
      category = options.delete(:category)
      return unless category
      options[:usage] = unprefix_attributes(category[:usage])
      options[:usage].transform_values! { |v| to_boolean(v) }

      options[:marketing_type] = unprefix_attributes(category[:marketing_type])
      options[:marketing_type].transform_values! { |v| to_boolean(v) }

      options[:type_id] = category.dig(:user_defined_simplefield, 0, :value)
      options[:sub_type_id] = category.dig(:user_defined_simplefield, 2, :value)
    end

    def process_geo(options)
      geo = options.delete(:geo)
      return unless geo
      options[:zip_code] = geo[:zip_code]
      options[:location] = geo[:location]
      options[:federal_state] = geo[:federal_state]
      options[:country] = geo.dig(:country, :@iso_country)

      %i[latitude longitude].each do |x|
        val = geo[:user_defined_simplefield].select do |y|
          mapper[y[:@field_name]] == "#{x}_precise".to_sym
        end
        options[x] = val.dig(0, :value)
      end
    end

    def process_management(options)
      management = options.delete(:management)
      return unless management
      %i[created_at updated_at].each do |x|
        val = management[:user_defined_simplefield].select do |y|
          mapper[y[:@field_name]] == x
        end
        options[x] = val.dig(0, :value)
      end
    end

    def process_technical(options)
      technical = options.delete(:technical)
      return unless technical
      technical.delete(:user_defined_simplefield)
      options.update(technical)
    end

    def process_free_text(options)
      free_text = options.delete(:free_text)
      return unless free_text
      options[:title] ||= free_text[:title]
      options[:description] ||= free_text[:description]
    end

    # subsections
    def process_sections(options)
      process_contact(options)
      process_prices(options)
      process_areas(options)
      process_attachments(options)
    end

    def process_contact(options)
      contact = options.delete(:contact)
      return unless contact
      options[:contact] = Justimmo::API::Employee.new(contact)
    end

    def process_prices(options)
      prices = options.delete(:prices)
      options[:prices] = Justimmo::API::Price.new(prices) do |keys, opts|
        keys.each do |key|
          next if @attributes.key?(key)
          new_value = options.delete(key)
          opts[key] ||= new_value
        end
      end
    end

    def process_areas(options)
      areas = options.delete(:areas)
      options[:areas] = Justimmo::API::Area.new(areas) do |keys, opts|
        keys.each do |key|
          next if @attributes.key?(key)
          new_value = options.delete(key)
          opts[key] ||= new_value
        end
      end
    end

    def process_attachments(options)
      attachments = options.delete(:attachments)

      options[:attachments] =
        case attachments
        when Array
          attachments.map { |x| Justimmo::API::Attachment.new(x) }
        when Hash
          tmp = attachments.fetch(:attachment)
          case tmp
          when Array then tmp.map { |x| Justimmo::API::Attachment.new(x) }
          when Hash  then [Justimmo::API::Attachment.new(tmp)]
          else       []
          end
        else
          []
        end
    end

    # utility methods
    def unprefix_attributes(hash)
      hash&.transform_keys do |key|
        key.to_s.sub(/^@/, '').to_sym
      end
    end

    def to_boolean(value)
      value == 1 ? true : false
    end

    def sanitize(options)
      options.select! { |k, _v| @attributes.keys.include?(k) }
    end
  end
end
