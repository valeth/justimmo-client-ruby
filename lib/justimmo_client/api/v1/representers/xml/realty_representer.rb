# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    REALTY_ROOMS = {
      store:           :anzahl_abstellraum,
      bathroom:        :anzahl_badezimmer,
      balcony_terrace: :anzahl_balkon_terrassen,
      balcony:         :anzahl_balkone,
      garden:          :anzahl_garten,
      garage:          :anzahl_garagen,
      loggia:          :anzahl_loggias,
      basement:        :anzahl_keller,
      toilet:          :anzahl_sep_wc,
      parking_space:   :anzahl_stellplaetze,
      total:           :anzahl_zimmer
    }.freeze

    REALTY_AREAS = {
      balcony_terrace:  :balkon_terrasse_flaeche,
      balcony:          :balkons_flaeche,
      office:           :bueroflaeche,
      garage:           :garagen_flaeche,
      garden:           :gartenflaeche,
      total:            :gesamtflaeche,
      surface:          :grundflaeche,
      property:         :grundstuecksflaeche,
      basement:         :kellerflaeche,
      storage:          :lagerflaeche,
      loggia:           :loggias_flaeche,
      floor:            :nutzflaeche,
      parking:          :stellplatz_flaeche,
      terrace:          :terrassen_flaeche,
      buildable:        :verbaubare_flaeche,
      sales:            :verkaufsflaeche,
      living:           :wohnflaeche
    }.freeze

    FILTERS = {
      sanitize_newline: ->(frag, _opt) { frag.gsub("\r\n", "\n") },
      str_to_a: ->(frag, _opt) { frag.split(",").map(&:strip) }
    }.freeze

    private_constant :REALTY_ROOMS
    private_constant :REALTY_AREAS
    private_constant :FILTERS

    class RealtyListRepresenter < JustimmoRepresenter
      property :title,  as: :titel
      property :teaser, as: :dreizeiler
      property :description,
        as: :objektbeschreibung,
        parse_filter: FILTERS[:sanitize_newline]

      property :status_id
      property :created_at, as: :erstellt_am
      property :updated_at, as: :aktualisiert_am

      property :id
      property :number, as: :objektnummer

      # nesting

      { first_image: :erstes_bild,
        second_image: :zweites_bild
      }.each do |key, api|
        property api, setter: ->(represented:, fragment:, **) do
          represented.attachments << Attachment.new(url: fragment)
        end
      end

      { location:  :ort,
        zip_code:  :plz,
        proximity: :naehe,
        floor:     :etage
      }.each do |key, value|
        property value, setter: ->(represented:, fragment:, **) do
          represented.geo ||= GeoLocation.new
          represented.geo.send("#{key}=", fragment)
        end
      end

      { purcase:   :kaufpreis,
        rent_cold: :gesamtmiete
      }.each do |key, value|
        property value, setter: ->(represented:, fragment:, **) do
          represented.price ||= RealtyPrice.new
          represented.price.send("#{key}=", fragment)
        end
      end

      REALTY_AREAS.each do |key, value|
        property key,
          as: value,
          setter: ->(fragment:, represented:, **) do
            represented.area ||= RealtyArea.new
            represented.area[key] = fragment
          end
      end

      REALTY_ROOMS.each do |key, value|
        property key,
          as: value,
          setter: ->(fragment:, represented:, **) do
            represented.room_count ||= RealtyRoomCount.new
            represented.room_count[key] = fragment
          end
      end
    end

    class ContactRepresenter < EmployeeRepresenter
      property :email_feedback
      property :email,      as: :email_direkt
      property :last_name,  as: :name
      property :company,    as: :firma
      property :salutation, as: :anrede
      property :phone,      as: :tel_zentrale
      property :mobile,     as: :tel_handy

      nested :bild do
        property :big, setter: ->(fragment:, represented:, **) do
          represented.attachments << Attachment.new(url: fragment)
        end
      end
    end

    class RealtyRepresenter < RealtyListRepresenter
      property :geo,
        decorator: GeoLocationRepresenter,
        class: GeoLocation

      property :contact,
        as: :kontaktperson,
        decorator: ContactRepresenter,
        class: Employee

      property :price,
        as: :preise,
        decorator: RealtyPriceRepresenter,
        class: RealtyPrice

      property :area, as: :flaechen, class: RealtyArea do
        REALTY_AREAS.each { |k, v| property k, as: v }
      end

      property :room_count, as: :flaechen, class: RealtyRoomCount do
        REALTY_ROOMS.each { |k, v| property k, as: v }
      end

      property :documents,
        as: :dokumente,
        parse_filter: ->(fragment, _options) { fragment.empty? ? nil : fragment }

      property :videos,
        parse_filter: ->(fragment, _options) { fragment.empty? ? nil : fragment }

      property :images360, as: :bilder360,
        parse_filter: ->(fragment, _options) { fragment.empty? ? nil : fragment }

      property :links,
        parse_filter: ->(fragment, _options) { fragment.empty? ? nil : fragment }

      collection :attachments,
        as: :anhang,
        wrap: :anhaenge,
        decorator: AttachmentRepresenter,
        class: Attachment

      # Unnesting

      nested :category, as: :objektkategorie do
        property :usage, as: :nutzungsart, class: RealtyUsage do
          property :living,     as: :WOHNEN,  attribute: true
          property :business,   as: :GEWERBE, attribute: true
          property :investment, as: :ANLAGE,  attribute: true
        end

        property :marketing, as: :vermarktungsart, class: RealtyMarketing do
          property :buy,  as: :KAUF,        attribute: true
          property :rent, as: :MIETE_PACHT, attribute: true
        end

        property :type_id,
          as: :user_defined_simplefield,
          parse_filter: ->(_fragment, options) do
            options[:doc].css("user_defined_simplefield[feldname=objektart_id]").text
          end

        property :sub_type_id,
          as: :user_defined_simplefield,
          parse_filter: ->(_fragment, options) do
            options[:doc].css("user_defined_simplefield[feldname=sub_objektart_id]").text
          end
      end

      nested :ausstattung do
      end

      nested :zustand_angaben do
        property :construction_year, as: :baujahr
      end

      nested :freitexte do
        property :title, as: :objekttitel

        property :description,
          as: :objektbeschreibung,
          parse_filter: FILTERS[:sanitize_newline]

        property :description_furniture,
          as: :ausstatt_beschr,
          parse_filter: FILTERS[:str_to_a]

        nested :user_defined_anyfield do
          property :furniture, as: :justimmo_moeblierung
        end
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

      nested :verwaltung_techn do
        property :id,          as: :objektnr_intern
        property :number,      as: :objektnr_extern
        property :openimmo_id, as: :openimmo_obid
      end

      collection_representer class: Realty
    end
  end
end
