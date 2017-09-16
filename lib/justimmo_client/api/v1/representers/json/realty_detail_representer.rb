# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class RealtyDetailRepresenter < JustimmoRepresenter
      property :category,
               decorator: RealtyCategoryRepresenter,
               class: RealtyCategory

      property :location,
               decorator: LocationRepresenter,
               class: Location

      property :contact,
               decorator: ContactRepresenter,
               class: Contact

      property :documents
      property :images360
      property :videos
      property :links

      property :title
      property :description
      property :description_furniture
      property :furniture

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

      property :available_from
      property :status_id
      property :id
      property :number
      property :openimmo_id

      collection :attachments,
                 decorator: AttachmentRepresenter,
                 class: Attachment
    end
  end
end
