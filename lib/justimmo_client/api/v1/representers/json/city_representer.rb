# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class CityRepresenter < JustimmoRepresenter
      property :id
      property :country_id
      property :region_id
      property :zip_code
      property :location
      property :federal_state_id

      collection_representer class: City
    end
  end
end
