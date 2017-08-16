# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyDetailItemRepresenter < RealtyRepresenter
      nested :verwaltung_techn do
        property :id,          as: :objektnr_intern
        property :number,      as: :objektnr_extern
        property :openimmo_id, as: :openimmo_obid
      end

      nested :verwaltung_objekt do
        property :available, as: :verfuegbar_ab
        property :status_id
        property :created_at,
          as: :user_defined_simplefield,
          parse_filter: ->(_fragment, options) { options[:doc].css("user_defined_simplefield[feldname=erstellt_am]").text }
        property :updated_at,
          as: :user_defined_simplefield,
          parse_filter: ->(_fragment, options) { options[:doc].css("user_defined_simplefield[feldname=aktualisiert_am]").text }
      end

      property :geo,
        decorator: GeoLocationRepresenter,
        class: GeoLocation

      property :contact,
        as: :kontaktperson,
        decorator: ContactRepresenter,
        class: Employee

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

      property :price,
        as: :preise,
        decorator: RealtyPriceRepresenter,
        class: RealtyPrice

      collection :images,
        as: :anhang,
        wrap: :anhaenge,
        class: Image do
          property :category, as: :gruppe, attribute: true
          property :origin, as: :location, attribute: true
          property :title, as: :anhangtitel
          nested :daten do
            %i[pfad small medium big2 medium2 s220x155 fullhd].each do |size|
              property size,
              setter: ->(represented:, fragment:, **) do
                represented.add_url(fragment, default: :big)
              end
            end
          end
        end

      # FIXME: Get rid of duplicate code!
      #        Duplicates in RealtyListRepresenter
      property :area,
        as: :flaechen,
        decorator: RealtyAreaRepresenter,
        class: RealtyArea

      property :room_count,
        as: :flaechen,
        decorator: RealtyRoomCountRepresenter,
        class: RealtyRoomCount

      property :documents, as: :dokumente
      property :images360, as: :bilder360
      property :videos
      property :links
    end

    class RealtyDetailRepresenter < JustimmoRepresenter
      property :realty,
        as: :immobilie,
        decorator: RealtyDetailItemRepresenter,
        class: Realty
    end
  end
end
