# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class FederalStateRepresenter < JustimmoRepresenter
      property :id
      property :name
      property :country_id
      property :fips
      property :iso

      collection_representer class: FederalState
    end
  end
end
