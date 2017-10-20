# frozen_string_literal: true

module JustimmoClient::V1
  # Public employee query interface
  module EmployeeInterface
    extend JustimmoClient::Utils
    extend JustimmoInterface

    module_function

    # @return [Array<Employee>]
    def list
      with_cache cache_key("employee/list"),
        on_hit: ->(cached) do
          representer(:employee, :json).for_collection.new([]).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:employee).list
          model = Struct.new(:employees).new
          represented = representer(:employee_list).new(model).from_xml(xml_response).employees
          new_cache = representer(:employee, :json).for_collection.new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end

    # @return [Employee]
    def detail(id)
      with_cache cache_key("employee/detail", id: id),
        on_hit: ->(cached) do
          representer(:employee, :json).new(model(:employee).new).from_json(cached)
        end,
        on_miss: -> do
          xml_response = request(:employee).detail(id)
          model = model(:employee).new
          represented = representer(:employee).new(model).from_xml(xml_response)
          new_cache = representer(:employee, :json).new(represented).to_json
          [represented, new_cache]
        end
    rescue JustimmoClient::RetrievalFailed
      nil
    end

    # @return [Array<Integer>]
    def ids
      with_cache cache_key("employee/ids"),
        on_hit: ->(cached) { ::JSON.parse(cached) },
        on_miss: -> do
          json_response = request(:employee).ids
          json_parsed = ::JSON.parse(json_response).map(&:to_i)
          [json_parsed, ::JSON.generate(json_parsed)]
        end
    rescue JustimmoClient::RetrievalFailed
      []
    end
  end
end
