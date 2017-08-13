# frozen_string_literal: true

require "json"

module JustimmoClient
  module Realty
    extend JustimmoClient::Utils

    module_function

    def list(options = {})
      xml_response = request(:realty).list(options)
      model = Struct.new(:realties).new
      representer(:realty_list).new(model).from_xml(xml_response).realties
    rescue JustimmoClient::RetrievalFailed
      []
    end

    def detail(id)
      xml_response = request(:realty).detail(id)
      model = Struct.new(:realty).new
      representer(:realty_detail).new(model).from_xml(xml_response).realty
    rescue JustimmoClient::RetrievalFailed
      nil
    end

    def details(options = {})
      ids(options).map { |id| detail(id) }
    end

    def ids(options = {})
      json_response = request(:realty).ids(options)
      ::JSON.parse(json_response).map(&:to_i)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    def categories(options = {})
      xml_response = request(:realty).categories(options)
      representer(:realty_category).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    def types(options = {})
      xml_response = request(:realty).types(options)
      representer(:realty_type).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    def countries(options = {})
      xml_response = request(:realty).countries(options)
      representer(:country).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    def federal_states(options = {})
      xml_response = request(:realty).federal_states(options)
      representer(:federal_state).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    def regions(options = {})
      xml_response = request(:realty).regions(options)
      representer(:region).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end

    def zip_codes_and_cities(options = {})
      xml_response = request(:realty).zip_codes_and_cities(options)
      representer(:city).for_collection.new([]).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      []
    end
  end
end
