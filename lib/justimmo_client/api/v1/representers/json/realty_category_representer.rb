# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyCategoryRepresenter < JustimmoRepresenter
      property :id
      property :name
      property :sortablerank

      collection_representer class: RealtyCategory
    end
  end
end
