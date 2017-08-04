# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RealtyRepresenter < JustimmoRepresenter
      property :id
      property :number, as: :objektnummer

      property :category,
               as: :objektkategorie,
               decorator: RealtyCategoryRepresenter,
               class: RealtyCategory

      property :title, as: :titel
      property :teaser, as: :dreizeiler
      property :proximity, as: :naehe

      property :description,
               as: :objektbeschreibung,
               parse_filter: ->(frag, _opt) { frag.gsub("\r\n", "\n") }

      property :floor, as: :etage
      property :location, as: :ort
      property :zip_code, as: :plz

      [
        %i[balcony_terrace_area  balkon_terrasse_flaeche],
        %i[balcony_area balkons_flaeche],
        %i[office_area bueroflaeche],
        %i[garage_area garagen_flaeche],
        %i[garden_area gartenflaeche],
        %i[total_area gesamtflaeche],
        %i[surface_area grundflaeche],
        %i[property_area grundstueksflaeche],
        %i[basement_area kellerflaeche],
        %i[storage_area lagerflaeche],
        %i[loggia_area loggias_flaeche],
        %i[floor_area nutzflaeche],
        %i[parking_area stellplatz_flaeche],
        %i[terrace_area terrassen_flaeche],
        %i[buildable_area verbaubare_flaeche],
        %i[sales_area verkaufsflaeche],
        %i[living_area wohnflaeche]
      ].each { |e| property e.first, as: e.last, type: Float }

      [
        %i[store_rooms anzahl_abstellraum],
        %i[bathrooms anzahl_badezimmer],
        %i[balconies_terraces anzahl_balkon_terrassen],
        %i[balconies anzahl_balkone],
        %i[balconies anzahl_balkons], # WTF
        %i[gardens anzahl_garten],
        %i[garages anzahl_garagen],
        %i[loggias anzahl_loggias],
        %i[basements anzahl_keller],
        %i[toilet_rooms anzahl_sep_wc],
        %i[parking_spaces anzahl_stellplaetze],
        %i[rooms anzahl_zimmer]
      ].each { |e| property e.first, as: e.last, type: Integer }

      property :first_image, as: :erstes_bild
      property :second_image, as: :zweites_bild
      property :status_id, type: Integer
      property :created_at, as: :erstellt_am, type: DateTime
      property :updated_at, as: :aktualisiert_am, type: DateTime
    end
  end
end
