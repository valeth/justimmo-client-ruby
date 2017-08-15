# frozen_string_literal: true

module JustimmoClient::V1
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

    # Basic data

    def categories(all: false)
      get("objekt/kategorien", alle: all ? 1 : 0)
    end

    def types(all: false)
      get("objekt/objektarten", alle: all ? 1 : 0)
    end

    def countries(all: false)
      get("objekt/laender", alle: all ? 1 : 0)
    end

    def federal_states(country:, all: false)
      get("objekt/bundeslaender", land: country, alle: all ? 1 : 0)
    end

    def regions(country: nil, federal_state: nil, all: false)
      get("objekt/regionen", land: country, bundesland: federal_state, alle: all ? 1 : 0)
    end

    def zip_codes_and_cities(country: nil, federal_state: nil, all: false)
      get("objekt/plzsUndOrte", land: country, bundesland: federal_state, alle: all ? 1 : 0)
    end
  end
end
