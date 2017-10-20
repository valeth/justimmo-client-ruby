# frozen_string_literal: true

require "json"

module JustimmoClient::V1
  # Public realty query interface
  #
  # Glues all components together.
  # Handles caching, parsing and converting XML and JSON into data models.
  module RealtyInterface
    extend JustimmoClient::Utils
    extend JustimmoInterface

    module_function

    # @option options [Integer] :limit (10)
    # @option options [Integer] :offset (0)
    # @option options [Symbol, String] :lang (:de)
    # @option options [Symbol, String] :orderby
    # @option options [Symbol, String] :ordertype (:asc)
    # @option options [Symbol, String] :picturesize (:small)
    # @option options [Boolean] :with_projects (false)
    # @option options [Float] :price_min
    # @option options [Float] :price_max
    # @option options [Float] :price_per_sqm_min
    # @option options [Float] :price_per_sqm_max
    # @option options [Integer] :type_id
    # @option options [Symbol, String, Array<Symbol, String>] :type
    # @option options [Integer] :sub_type_id
    # @option options [Symbol, String] :tag
    # @option options [String, Integer] :zip_code
    # @option options [String, Integer] :zip_code_min
    # @option options [String, Integer] :zip_code_max
    # @option options [Integer] :rooms_min
    # @option options [Integer] :rooms_max
    # @option options [Integer] :number
    # @option options [Integer] :number_min
    # @option options [Integer] :number_max
    # @option options [Float] :area_min
    # @option options [Float] :area_max
    # @option options [Float] :living_area_min
    # @option options [Float] :living_area_max
    # @option options [Float] :floor_area_min
    # @option options [Float] :floor_area_max
    # @option options [Float] :surface_area_min
    # @option options [Float] :surface_area_max
    # @option options [Symbol, String] :keyword
    # @option options [Integer] :country_id
    # @option options [Integer] :federal_state_id
    # @option options [Integer] :status_id
    # @option options [Boolean] :rent
    # @option options [Boolean] :purcase
    # @option options [Integer] :owner_id
    # @option options [Integer] :project_id
    # @option options [String] :system_type
    # @option options [Integer] :parent_id
    # @option options [DateTime] :updated_at_min
    # @option options [DateTime] :updated_at_max
    # @option options [String] :location
    # @return [Array<Realty>] An array of basic realty objects, or an empty array on error.
    def list(options = {})
      with_cache cache_key("realty/list", options),
        on_hit: ->(cached) do
          representer(:realty, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          model = Struct.new(:realties).new
          xml_response = request(:realty).list(options)
          represented = representer(:realty_list).new(model).from_xml(xml_response).realties
          new_cache = representer(:realty, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @param [Integer] id
    # @param [Symbol, String] lang
    # @return [Realty, nil] A detailed realty object, or nil if it could not be found.
    def detail(id, lang: nil)
      with_cache cache_key("realty/detail", lang: lang),
        on_hit: ->(cached) do
          representer(:realty, :json).new(model(:realty).new).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:realty).detail(id, lang: lang)
          model = Struct.new(:realty).new
          represented = representer(:realty_detail).new(model).from_xml(xml_response).realty
          new_cache = representer(:realty, :json).new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      nil
    end

    # @see list
    # @return [Array<Realty>] An array of detailed realty objects, or an empty array on error.
    def details(options = {})
      ids(options).map { |id| detail(id) }
    end

    # @option (see list)
    # @return [Array<Integer>] An array of realty ids, empty array if no results.
    def ids(options = {})
      with_cache cache_key("realty/ids", options),
        on_hit: ->(cached) { ::JSON.parse(cached) },
        on_miss: -> do
          json_response = request(:realty).ids(options)
          json_parsed = ::JSON.parse(json_response).map(&:to_i)
          [json_parsed, ::JSON.generate(json_parsed)]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @return [Array<RealtyCategory>]
    def categories(options = {})
      with_cache cache_key("realty/categories", options),
        on_hit: ->(cached) do
          representer(:realty_category, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:realty).categories(options)
          represented = representer(:realty_category).for_collection.new([]).from_xml(xml_response)
          new_cache = representer(:realty_category, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @return [Array<RealtyType>]
    def types(options = {})
      with_cache cache_key("realty/types", options),
        on_hit: ->(cached) do
          representer(:realty_type, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:realty).types(options)
          represented = representer(:realty_type).for_collection.new([]).from_xml(xml_response)
          new_cache = representer(:realty_type, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @return [Array<Country>]
    def countries(options = {})
      with_cache cache_key("realty/countries", options),
        on_hit: ->(cached) do
          representer(:country, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:realty).countries(options)
          represented = representer(:country).for_collection.new([]).from_xml(xml_response)
          new_cache = representer(:country, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @option options [Integer] :country (nil)
    # @return [Array<FederalState>]
    def federal_states(options = {})
      with_cache cache_key("realty/federal_states", options),
        on_hit: ->(cached) do
          representer(:federal_states, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:realty).federal_states(options)
          represented = representer(:federal_state).for_collection.new([]).from_xml(xml_response)
          new_cache = representer(:federal_state, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @option options [Integer] :country (nil)
    # @option options [Integer] :federal_state (nil)
    # @return [Array<Region>]
    def regions(options = {})
      with_cache cache_key("realty/regions", options),
        on_hit: ->(cached) do
          representer(:region, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:realty).regions(options)
          represented = representer(:region).for_collection.new([]).from_xml(xml_response)
          new_cache = representer(:region, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @option options [Integer] :country (nil)
    # @option options [Integer] :federal_state (nil)
    # @return [Array<City>]
    def zip_codes_and_cities(options = {})
      with_cache cache_key("realty/cities", options),
        on_hit: ->(cached) do
          representer(:city, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:realty).zip_codes_and_cities(options)
          represented = representer(:city).for_collection.new([]).from_xml(xml_response)
          new_cache = representer(:city, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end
  end
end
