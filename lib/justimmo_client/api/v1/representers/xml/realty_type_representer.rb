# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyTypeRepresenter < JustimmoRepresenter
      self.representation_wrap = :objektart

      property :id
      property :name

      collection_representer class: RealtyType
    end
  end
end
