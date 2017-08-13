# frozen_string_literal: true

module Justimmo::V1
  module XML
    class FederalStateRepresenter < JustimmoRepresenter
      self.representation_wrap = :bundesland

      property :id
      property :name
      property :country_id, as: :landid
      property :fips, as: :fipscode
      property :iso, as: :iso31662code

      collection_representer class: FederalState
    end
  end
end
