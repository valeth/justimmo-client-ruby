# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RealtyCategoryRepresenter < JustimmoRepresenter
      self.representation_wrap = :objektkategorie

      property :id
      property :name
      property :sortablerank

      collection_representer class: RealtyCategory
    end
  end
end
