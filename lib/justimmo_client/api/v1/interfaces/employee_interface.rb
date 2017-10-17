# frozen_string_literal: true

module JustimmoClient::V1
  # Public employee query interface
  module EmployeeInterface
    extend JustimmoClient::Utils

    module_function

    # @return [Array<Employee>]
    def list
      xml_response = request(:employee).list
      model = Struct.new(:employees).new
      representer(:employee_list).new(model).from_xml(xml_response).employees
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @return [Employee]
    def detail(id)
      xml_response = request(:employee).detail(id)
      model = model(:employee).new
      representer(:employee).new(model).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      nil
    end

    # @return [Array<Integer>]
    def ids
      json_response = request(:employee).ids
      ::JSON.parse(json_response).map(&:to_i)
    rescue JustimmoClient::RetrievalFailed
      []
    end
  end
end
