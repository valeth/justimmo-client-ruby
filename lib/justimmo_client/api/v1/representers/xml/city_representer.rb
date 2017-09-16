# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class CityRepresenter < JustimmoRepresenter
      self.representation_wrap = :postleitzahl

      property :id
      property :country_id, as: :landid
      property :region_id, as: :regionid
      property :zip_code, as: :plz
      property :location, as: :ort
      property :federal_state_id, as: :bundeslandid

      collection_representer class: City
    end
  end
end
