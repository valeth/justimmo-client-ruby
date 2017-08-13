# frozen_string_literal: true

module Justimmo
  module Employee
    extend Justimmo::Utils

    module_function

    def list
      xml_response = request(:employee).list
      model = Struct.new(:employees).new
      representer(:employee_list).new(model).from_xml(xml_response).employees
    rescue Justimmo::RetrievalFailed
      []
    end

    def detail(id)
      xml_response = request(:employee).detail(id)
      model = model(:employee).new
      representer(:employee).new(model).from_xml(xml_response)
    rescue Justimmo::RetrievalFailed
      nil
    end

    def ids
      json_response = request(:employee).ids
      ::JSON.parse(json_response).map(&:to_i)
    rescue Justimmo::RetrievalFailed
      []
    end
  end
end
