# frozen_string_literal: true

require "justimmo/api/v1/models/attachment"
require "justimmo/api/v1/models/contact"
require "justimmo/api/v1/models/location"
require "justimmo/api/v1/models/realty_category"
require_relative "justimmo_representer"
require_relative "attachment_representer"
require_relative "contact_representer"
require_relative "location_representer"
require_relative "realty_category_representer"

module Justimmo
  module V1
    module XML
      class RealtyDetailRepresenter < JustimmoRepresenter
        nested :immobilie do
          # property :prices, as: :preise
          # property :furnishing, as: :ausstattung
          # property :condition, as: :zustand_angaben

          property :category,
                   as: :objektkategorie,
                   decorator: RealtyCategoryRepresenter,
                   class: RealtyCategory

          property :location,
                   as: :geo,
                   decorator: LocationRepresenter,
                   class: Location

          property :contact,
                   as: :kontaktperson,
                   decorator: ContactRepresenter,
                   class: Contact

          property :documents, as: :dokumente
          property :images360, as: :bilder260
          property :videos
          property :links

          nested :freitexte do
            property :title, as: :objekttitel
            property :description, as: :objektbeschreibung

            property :description_furniture,
                     as: :ausstatt_beschr,
                     parse_filter: ->(frag, _opt) { frag.split(",").map(&:strip) }

            nested :user_defined_anyfield do
              property :furniture, as: :justimmo_moeblierung, type: Array
            end
          end

          nested :flaechen do
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
          end

          nested :verwaltung_objekt do
            property :available_from, as: :verfuegbar_ab, type: DateTime
            property :status_id, type: Integer
          end

          nested :verwaltung_techn do
            property :id, as: :objektnr_intern, type: Integer
            property :number, as: :objektnr_extern, type: Integer
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
end
