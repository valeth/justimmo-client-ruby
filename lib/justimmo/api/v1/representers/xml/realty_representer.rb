# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RealtyRepresenter < JustimmoRepresenter
      property :id
      property :status_id
      property :number,               as: :objektnummer
      property :title,                as: :titel
      property :teaser,               as: :dreizeiler
      property :proximity,            as: :naehe
      property :floor,                as: :etage
      property :location,             as: :ort
      property :zip_code,             as: :plz
      property :first_image,          as: :erstes_bild
      property :second_image,         as: :zweites_bild
      property :created_at,           as: :erstellt_am
      property :updated_at,           as: :aktualisiert_am
      property :balcony_terrace_area, as: :balkon_terrasse_flaeche
      property :balcony_area,         as: :balkons_flaeche
      property :office_area,          as: :bueroflaeche
      property :garage_area,          as: :garagen_flaeche
      property :garden_area,          as: :gartenflaeche
      property :total_area,           as: :gesamtflaeche
      property :surface_area,         as: :grundflaeche
      property :property_area,        as: :grundstueksflaeche
      property :basement_area,        as: :kellerflaeche
      property :storage_area,         as: :lagerflaeche
      property :loggia_area,          as: :loggias_flaeche
      property :floor_area,           as: :nutzflaeche
      property :parking_area,         as: :stellplatz_flaeche
      property :terrace_area,         as: :terrassen_flaeche
      property :buildable_area,       as: :verbaubare_flaeche
      property :sales_area,           as: :verkaufsflaeche
      property :living_area,          as: :wohnflaeche
      property :store_rooms,          as: :anzahl_abstellraum
      property :bathrooms,            as: :anzahl_badezimmer
      property :balconies_terraces,   as: :anzahl_balkon_terrassen
      property :balconies,            as: :anzahl_balkone
      property :balconies,            as: :anzahl_balkons
      property :gardens,              as: :anzahl_garten
      property :garages,              as: :anzahl_garagen
      property :loggias,              as: :anzahl_loggias
      property :basements,            as: :anzahl_keller
      property :toilet_rooms,         as: :anzahl_sep_wc
      property :parking_spaces,       as: :anzahl_stellplaetze
      property :rooms,                as: :anzahl_zimmer

      property :category,
        as: :objektkategorie,
        decorator: RealtyCategoryRepresenter,
        class: RealtyCategory

      property :description,
        as: :objektbeschreibung,
        parse_filter: ->(frag, _opt) { frag.gsub("\r\n", "\n") }

      collection_representer class: Realty
    end
  end
end
