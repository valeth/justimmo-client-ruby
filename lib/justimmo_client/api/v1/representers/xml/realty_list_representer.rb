# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class RealtyListItemRepresenter < RealtyRepresenter
      property :id
      property :number, as: :objektnummer

      property :created_at, as: :erstellt_am
      property :updated_at, as: :aktualisiert_am
      property :status_id

      property :title,  as: :titel
      property :teaser, as: :dreizeiler
      property :description,
        as: :objektbeschreibung,
        parse_filter: ->(frag, _opt) { frag.gsub("\r\n", "\n") }

      property :floor, as: :etage

      # Move some attributes into "sub-objects"

      { first_image: :erstes_bild, second_image: :zweites_bild }.each do |key, api|
        property api, setter: ->(represented:, fragment:, **) { represented.add_image(fragment) }
      end

      { location: :ort,
        zip_code: :plz,
        proximity: :naehe
      }.each do |key, api|
        property api, setter: ->(represented:, fragment:, **) { represented.geo.send("#{key}=", fragment) }
      end

      { balcony_terrace:  :balkon_terrasse_flaeche,
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
      }.each do |key, api|
        property key,
          as: api,
          setter: ->(fragment:, represented:, **) { represented.area[key] = fragment },
          getter: ->(represented:, **) { represented.area[key] }
      end

      { store: :anzahl_abstellraum,
        bathroom: :anzahl_badezimmer,
        balcony_terrace: :anzahl_balkon_terrassen,
        balcony: :anzahl_balkone,
        garden: :anzahl_garten,
        garage: :anzahl_garagen,
        loggia: :anzahl_loggias,
        basement: :anzahl_keller,
        toilet: :anzahl_sep_wc,
        parking_space: :anzahl_stellplaetze,
        total: :anzahl_zimmer
      }.each do |key, api|
        property key,
          as: api,
          setter: ->(fragment:, represented:, **) { represented.room_count[key] = fragment },
          getter: ->(represented:, **) { represented.room_count[key] }
      end
    end

    class RealtyListRepresenter < JustimmoRepresenter
      collection :realties,
        as: :immobilie,
        wraps: :immobilie,
        decorator: RealtyListItemRepresenter,
        class: Realty
    end
  end
end
