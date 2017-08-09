# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RealtyCategoryRepresenter < JustimmoRepresenter
      nested :objektkategorie do
        property :id
        property :name
        property :sortablerank
      end
    end
  end
end
