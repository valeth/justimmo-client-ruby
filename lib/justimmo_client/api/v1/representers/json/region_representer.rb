# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RegionRepresenter < JustimmoRepresenter
      property :id
      property :name

      collection_representer class: Region
    end
  end
end
