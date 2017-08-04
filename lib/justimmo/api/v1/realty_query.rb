# frozen_string_literal: true

require "json"
require "justimmo/api/v1/mapper"

module Justimmo::API
  # Get realty information from the API.
  module RealtyQuery
    extend Justimmo::API::Query

    module_function

    # Search for a list of realties.
    # @param params [Hash]
    #   Search parameters.
    # @option params [Integer] :limit (10)
    #   Amount of retrieved list items. *Max*: 100.
    # @option params [Integer] :offset (0)
    #   Offset of the first list item.
    # @option params [String] :language ('de')
    #   Language for i18n fields.
    # @option params [Symbol] :orderby (:asc)
    #   Order direction. Either :asc or :desc.
    # @option params [Symbol] :order
    #   Order by specific field.
    #   One of :price, :zip_code, :created_at, :realty_number,
    #   :updated_at and :published_at.
    # @option params [Symbol] :picturesize (:small)
    #   The picture size for image urls. One of :small, :medium, :large.
    # @option params [Boolean] :all (false)
    #   Show all realties with projects, disregarding realty state.
    # @option params [Hash] :filter
    #   See {RealtyQuery.build_filter} for options.
    # @return [Array<String>]
    def list(params = {})
      cache_key = Digest::SHA256.hexdigest("realty/list:#{params}")
      with_cache(cache_key) { request("objekt/list", params) }
    end

    # @param id [Integer] The realty id to search.
    # @param params [Hash] Additional parameters.
    # @option params [String] :language
    # @return [String]
    def detail(id, params = {})
      params.update(realty_id: id)
      cache_key = Digest::SHA256.hexdigest("realty/detail:#{params}")
      with_cache(cache_key) { request("objekt/detail", params) }
    end

    # Get the content of the expose PDF file as stream.
    # @param params [Hash]
    # @option params [Integer] :realty_id
    # @option params [String] :expose
    # @option params [String] :language
    # @return [Tempfile] The PDF file.
    def expose(params = {})
      tmpfile = Tempfile.open(["justimmo-expose", ".pdf"])
      response = request("objekt/expose", params)
      tmpfile.write(response)
      yield(tmpfile) if block_given?
      tmpfile
    end

    # Create an inquiry.
    # @param params [Hash]
    # @option params [Integer] :realty_id
    # @option params [Integer] :salutation_id
    # @option params [String] :title
    # @option params [String] :first_name
    # @option params [String] :last_name
    # @option params [String] :email
    # @option params [String] :phone
    # @option params [String] :message
    # @option params [String] :street
    # @option params [Integer] :zip_code
    # @option params [String] :location
    # @option params [String] :country
    # @return [nil]
    def inquiry(params = {})
      request("objekt/anfrage", params)
      nil
    end

    # List of ids for realties matching the filters.
    # @param (see list)
    # @option (see list)
    # @return [Array<Integer>] List of ids.
    def ids(params = {})
      cache_key = Digest::SHA256.hexdigest("realty/ids:#{params}")
      response = with_cache(cache_key) { request("objekt/ids", params) }
      JSON.parse(response).map(&:to_i)
    rescue JSON::ParserError => e
      log.error(e)
      []
    end

    # Translate internal search parameters to API ones.
    # @param params [Hash]
    # @return [Hash]
    def build_params(params = {})
      params.reduce({}) do |acc, (key, value)|
        map = { map: :params }
        case key
        when :orderby then acc.update(key => mapper[value, reverse: true])
        when :filter  then acc.update(key => build_filter(value))
        else          acc.update(mapper[key, map] => parse_value(value))
        end
      end
    end

    # Translate a filter from internal to API format.
    # @param filter [Hash] The internal filter.
    # @option filter [Integer] :price_min
    # @option filter [Integer] :price_max
    # @option filter [Integer] :price_per_sqm_min
    # @option filter [Integer] :price_per_sqm_max
    # @option filter [Integer, Array<Integer>] :realty_type_id
    # @option filter [Integer, Array<Integer>] :sub_realty_type_id
    # @option filter [String] :tag
    # @option filter [Integer] :zip_code
    # @option filter [Integer] :zip_code_min
    # @option filter [Integer] :zip_code_max
    # @option filter [Integer] :room_count_min
    # @option filter [Integer] :room_count_max
    # @option filter [Integer] :realty_number
    # @option filter [Integer] :realty_number_min
    # @option filter [Integer] :realty_number_max
    # @option filter [Integer] :area_min
    # @option filter [Integer] :area_max
    # @option filter [Integer] :living_area_min
    # @option filter [Integer] :living_area_max
    # @option filter [Integer] :floor_area_min
    # @option filter [Integer] :floor_area_max
    # @option filter [Integer] :surface_area_min
    # @option filter [Integer] :surface_area_max
    # @option filter [String] :keyword
    # @option filter [Integer] :country_id
    # @option filter [Integer] :federal_state_id
    # @option filter [Integer] :realty_status_id
    # @option filter [Boolean] :rent
    # @option filter [Boolean] :purcase
    # @option filter [Integer] :owner_id
    # @option filter [Integer] :project_id
    # @option filter [String] :realty_type
    # @option filter [Integer] :parent_id
    # @option filter [DateTime] :updated_at_min
    # @option filter [DateTime] :updated_at_max
    # @return [Hash] The API filter.
    def build_filter(filter = {})
      filter.reduce({}) do |acc, (key, value)|
        acc.update(mapper[key, map: :filter] => value)
      end
    end

    def mapper
      Mapper[:realty]
    end
  end
end
