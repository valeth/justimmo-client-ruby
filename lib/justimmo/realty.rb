# frozen_string_literal: true

require "json"

module Justimmo
  module Realty
    extend Justimmo::Utils

    module_function

    def list(options = {})
      xml_response = request(:realty).list(options)
      model = Struct.new(:realties).new
      representer(:realty_list).new(model).from_xml(xml_response).realties
    rescue Justimmo::RetrievalFailed
      []
    end

    def detail(id)
      xml_response = request(:realty).detail(id)
      model = Struct.new(:realty).new
      representer(:realty_detail).new(model).from_xml(xml_response).realty
    rescue Justimmo::RetrievalFailed
      nil
    end

    def details(options = {})
      ids(options).map { |id| detail(id) }
    end

    def ids(options = {})
      json_response = request(:realty).ids(options)
      ::JSON.parse(json_response).map(&:to_i)
    rescue Justimmo::RetrievalFailed
      []
    end
  end
end
