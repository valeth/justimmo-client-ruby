# frozen_string_literal: true

module JustimmoClient::V1
  module RealtyRequest
    extend JustimmoRequest

    # Mappings for the option parser
    TRANSLATION_MAPPING = {
      limit: :Limit,
      offset: :Offset,
      lang: :culture,
      with_projects: :alleProjektObjekte,
      number: :objektnummer,
      price: :preis,
      zip_code: :plz,
      price_per_sqm: :preis_per_m2,
      type: :objektart,
      subtype: :subobjektart,
      tag: :tagname,
      room_count: :zimmer,
      area: :flaeche,
      living_area: :wohnflaeche,
      floor_area: :nutzflaeche,
      surface_area: :grundflaeche,
      keyword: :stichwort,
      country: :land,
      federal_state: :bundesland,
      small_undbanded: :small,
      small2_unbranded: :s220x155,
      small3_unbranded: :s312x208,
      id: :objekt_id,
      salutation: :anrede,
      title: :titel,
      first_name: :vorname,
      last_name: :nachname,
      phone: :tel,
      location: :ort
    }.freeze

    module_function

    # @param [Hash] params
    # @return [String] The requested XML.
    def list(**params)
      get("objekt/list", list_option_parser.parse(params))
    end

    # @param [Integer] id
    # @param [String, Symbol] lang
    # @return [String] The requested XML.
    def detail(id, lang: nil)
      get("objekt/detail", objekt_id: id, culture: lang)
    end

    # @param [Integer] id
    # @param [Hash] params
    # @return [String] The requested XML.
    def inquiry(id, **params)
      options = inquiry_option_parser.parse(params)
      options[:objekt_id] = id

      get("objekt/anfrage", options)
    end

    # @param [Hash] params
    # @return [String] A JSON string containing an array of ids.
    def ids(**params)
      get("objekt/ids", params)
    end

    # TODO: implement this
    # @param [Hash] params
    # @return [File] The PDF file.
    def expose(**params)
      get("objekt/expose", params)
    end

    # Basic data

    # @param [Boolean] all (false)
    # @return [String] The requested XML.
    def categories(all: false)
      get("objekt/kategorien", alle: all ? 1 : 0)
    end

    # @param [Boolean] all (false)
    # @return [String] The requested XML.
    def types(all: false)
      get("objekt/objektarten", alle: all ? 1 : 0)
    end

    # @param [Boolean] all (false)
    # @return [String] The requested XML.
    def countries(all: false)
      get("objekt/laender", alle: all ? 1 : 0)
    end

    # @param [Boolean] all (false)
    # @param [Integer, String] country
    # @return [String] The requested XML.
    def federal_states(country:, all: false)
      get("objekt/bundeslaender", land: country, alle: all ? 1 : 0)
    end

    # @param [Boolean] all (false)
    # @param [Integer, String] country
    # @param [Integer] federal_state
    # @return [String] The requested XML.
    def regions(country: nil, federal_state: nil, all: false)
      get("objekt/regionen", land: country, bundesland: federal_state, alle: all ? 1 : 0)
    end

    # @param [Boolean] all (false)
    # @param [Integer, String] country
    # @param [Integer] federal_state
    # @return [String] The requested XML.
    def zip_codes_and_cities(country: nil, federal_state: nil, all: false)
      get("objekt/plzsUndOrte", land: country, bundesland: federal_state, alle: all ? 1 : 0)
    end

    # Option parsers

    # @return [Hash]
    def list_option_parser
      @option_parsers ||= {}
      @option_parsers[:list] ||= JustimmoClient::OptionParser.new do |options|
        options.mappings = TRANSLATION_MAPPING
        options.range_suffix = %i[_von _bis]

        options.add :limit
        options.add :offset
        options.add :lang
        options.add :orderby, values: %w[price zip_code number created_at updated_at published_at]
        options.add :ordertype, values: %w[asc desc]
        options.add :picturesize, values: %w[small_unbranded small2_unbranded small3_unbranded medium_unbranded big_unbranded big2_unbranded medium big bin2]
        options.add :with_projects, type: :bool
        options.group :filter do |f|
          f.add :price_min
          f.add :price_max
          f.add :price_per_sqm_min
          f.add :price_per_sqm_max
          f.add :type_id
          f.add :subtype_id
          f.add :tag
          f.add :zip_code
          f.add :zip_code_min
          f.add :zip_code_max
          f.add :room_count_min
          f.add :room_count_max
          f.add :number
          f.add :number_min
          f.add :number_max
          f.add :area_min
          f.add :area_max
          f.add :living_area_min
          f.add :living_area_max
          f.add :floor_area_min
          f.add :floor_area_max
          f.add :surface_area_min
          f.add :surface_area_max
          f.add :keyword
          f.add :country_id
          f.add :federal_state_id
          f.add :status_id
          f.add :project_id
          f.add :type
          f.add :parent_id
          f.add :updated_at_min, as: :aktualisiert_am_von
          f.add :updated_at_max, as: :aktualisiert_am_bis
        end
      end
    end

    # @return [Hash]
    def inquiry_option_parser
      @option_parsers ||= {}
      @option_parsers[:inquiry] = JustimmoClient::OptionParser.new do |options|
        options.mappings = TRANSLATION_MAPPING
        options.range_suffix = %i[_von _bis]

        options.add :salutation_id
        options.add :title
        options.add :first_name
        options.add :last_name
        options.add :email
        options.add :phone
        options.add :message
        options.add :street
        options.add :zip_code
        options.add :location
        options.add :country
      end
    end
  end
end
