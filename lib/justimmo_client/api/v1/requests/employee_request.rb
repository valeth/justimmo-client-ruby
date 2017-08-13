# frozen_string_literal: true

require "json"

module JustimmoClient::V1
  module EmployeeRequest
    extend JustimmoRequest

    module_function

    def list
      get("team/list")
    end

    def detail(id)
      get("team/detail", id: id)
    end

    def ids
      get("team/ids")
    end
  end
end
