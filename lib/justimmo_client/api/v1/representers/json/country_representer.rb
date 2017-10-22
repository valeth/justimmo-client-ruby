# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class CountryRepresenter < JustimmoRepresenter
      property :id
      property :alpha2
      property :alpha3
      property :name

      collection_representer class: Country
    end
  end
end
