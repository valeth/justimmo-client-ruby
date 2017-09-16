# frozen_string_literal: true

module JustimmoClient
  # Public employee query interface
  module Employee
    extend JustimmoClient::Utils

    module_function

    # Retrieve a list of employee data.
    # @return [Array<Object>]
    def list
      xml_response = request(:employee).list
      model = Struct.new(:employees).new
      representer(:employee_list).new(model).from_xml(xml_response).employees
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # Retrieve detailed information about a single employee.
    # @param id [Integer] The ID of the employee
    # @return [Object]
    def detail(id)
      xml_response = request(:employee).detail(id)
      model = model(:employee).new
      representer(:employee).new(model).from_xml(xml_response)
    rescue JustimmoClient::RetrievalFailed
      nil
    end

    # @return [Array<Integer>] An array of employee IDs
    def ids
      json_response = request(:employee).ids
      ::JSON.parse(json_response).map(&:to_i)
    rescue JustimmoClient::RetrievalFailed
      []
    end
  end
end
