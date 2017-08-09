# frozen_string_literal: true

module Justimmo::V1
  module RealtyRequest
    extend JustimmoRequest

    module_function

    # @return String
    def list(options = {})
      get("objekt/list", options)
    end

    # @return String
    def detail(id)
      get("objekt/detail", objekt_id: id)
    end

    # @return String
    def inquiry(options = {})
      get("objekt/anfrage", options)
    end

    # @return String
    def ids(options = {})
      get("objekt/ids", options)
    end

    # @return File
    def expose(options = {})
      get("objekt/expose", options)
    end
  end
end
