# frozen_string_literal: true

module Justimmo::V1
  module XML
    class RealtyDetailRepresenter < RealtyRepresenter
      # Filters
      latitude_filter = lambda do |_fragment, options|
        options[:doc].css("user_defined_simplefield[feldname=geokoordinaten_breitengrad_exakt]").text
      end

      longitude_filter = lambda do |_fragment, options|
        options[:doc].css("user_defined_simplefield[feldname=geokoordinaten_laengengrad_exakt]").text
      end

      nested :immobilie do
        nested :geo do
          property :federal_state, as: :bundesland

          nested :land do
            property :country, as: :iso_land, attribute: true
          end

          property :latitude,
            as: :user_defined_simplefield,
            parse_filter: latitude_filter

          property :longitude,
            as: :user_defined_simplefield,
            parse_filter: longitude_filter
        end

        property :contact,
                 as: :kontaktperson,
                 decorator: EmployeeRepresenter,
                 class: Employee

        property :category,
          as: :objektkategorie,
          decorator: RealtyCategoryRepresenter,
          class: RealtyCategory

        property :documents, as: :dokumente
        property :images360, as: :bilder360
        property :videos
        property :links

        nested :freitexte do
          property :title, as: :objekttitel

          property :description,
            as: :objektbeschreibung,
            parse_filter: ->(frag, _opt) { frag.gsub("\r\n", "\n") }

          property :description_furniture,
            as: :ausstatt_beschr,
            parse_filter: ->(frag, _opt) { frag.split(",").map(&:strip) }

          nested :user_defined_anyfield do
            property :furniture, as: :justimmo_moeblierung
          end
        end

        nested :flaechen do
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
        end

        nested :verwaltung_objekt do
          property :available_from, as: :verfuegbar_ab
          property :status_id
        end

        nested :verwaltung_techn do
          property :id,          as: :objektnr_intern
          property :number,      as: :objektnr_extern
          property :openimmo_id, as: :openimmo_obid
        end

        collection :attachments,
          as: :anhang,
          wrap: :anhaenge,
          decorator: AttachmentRepresenter,
          class: Attachment
      end
    end
  end
end
