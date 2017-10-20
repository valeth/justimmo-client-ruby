# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyTypeRepresenter < JustimmoRepresenter
      property :id
      property :name

      collection_representer class: RealtyType
    end
  end
end
