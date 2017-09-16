# frozen_string_literal: true

require "json"

module JustimmoClient
  # Public realty query interface
  module Realty
    extend JustimmoClient::Utils

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
    # @option options [Symbol, String] :type
    # @option options [Integer] :parent_id
    # @option options [DateTime] :updated_at_min
    # @option options [DateTime] :updated_at_max
    # @example Filter by zip code and limit to three results.
    #    JustimmoClient::Realty.list(zip_code: 6800, limit: 3)
    # @return [Array<Object>] An array of basic realty objects, or an empty array on error.
    def list(options = {})
      xml_response = request(:realty).list(options)
      model = Struct.new(:realties).new
      representer(:realty_list).new(model).from_xml(xml_response).realties
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @param [Integer] id
    # @param [Symbol, String] lang
    # @return [Object, nil] A detailed realty object, or nil if it could not be found.
    def detail(id, lang: nil)
      xml_response = request(:realty).detail(id: id, lang: lang)
      model = Struct.new(:realty).new
      representer(:realty_detail).new(model).from_xml(xml_response).realty
    rescue JustimmoClient::RetrievalFailed
      nil
    end

    # @see list
    # @return [Array<Object>] An array of detailed realty objects, or an empty array on error.
    def details(options = {})
      ids(options).map { |id| detail(id) }
    end

    # @see list
    # @return [Array<Integer>] An array of realty ids, empty array if no results.
    def ids(options = {})
      json_response = request(:realty).ids(options)
      ::JSON.parse(json_response).map(&:to_i)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @return [Array<Object>]
    def categories(options = {})
      xml_response = request(:realty).categories(options)
      representer(:realty_category).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @return [Array<Object>]
    def types(options = {})
      xml_response = request(:realty).types(options)
      representer(:realty_type).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @return [Array<Object>]
    def countries(options = {})
      xml_response = request(:realty).countries(options)
      representer(:country).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @option options [Integer] :country (nil)
    # @return [Array<Object>]
    def federal_states(options = {})
      xml_response = request(:realty).federal_states(options)
      representer(:federal_state).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @option options [Integer] :country (nil)
    # @option options [Integer] :federal_state (nil)
    # @return [Array<Object>]
    def regions(options = {})
      xml_response = request(:realty).regions(options)
      representer(:region).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @option options [Boolean] :all (false)
    # @option options [Integer] :country (nil)
    # @option options [Integer] :federal_state (nil)
    # @return [Array<Object>]
    def zip_codes_and_cities(options = {})
      xml_response = request(:realty).zip_codes_and_cities(options)
      representer(:city).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end
  end
end
