# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RegionRepresenter < JustimmoRepresenter
      self.representation_wrap = :region

      property :id
      property :name

      collection_representer class: Region
    end
  end
end
