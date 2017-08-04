# frozen_string_literal: true

module Justimmo
  module Realty
    extend Justimmo::Utils

    RealtyList = Struct.new(:realties)

    module_function

    def list(options = {})
      xml_response = request(:realty).list(options)
      model = RealtyList.new
      representer(:realty_list).new(model).from_xml(xml_response).realties
    end

    def detail(id)
      xml_response = request(:realty).detail(id)
      model = model(:realty).new
      representer(:realty_detail).new(model).from_xml(xml_response)
    end

    def ids
      json_response = request(:realty).ids
      ::JSON.parse(json_response).map(&:to_i)
    end
  end
end
