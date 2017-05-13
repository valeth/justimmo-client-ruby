require 'justimmo/realty/realty_mapper'
require 'justimmo/realty/realty_category'
require 'justimmo/realty/realty_geo'
require 'justimmo/realty/realty_contact'
require 'justimmo/realty/realty_price'
require 'justimmo/utils'
require 'nokogiri'

module Justimmo
  class RealtyBuilder < Justimmo::Utils::XMLBuilder
    def build
      @attributes.map do |elem|
        Realty.new(elem)
      end
    end

    private

    def mapper
      Justimmo::RealtyMapper
    end
  end

  class RealtyListBuilder < RealtyBuilder
    private

    def parse(xml)
      xml.xpath('//immobilie').each do |realty|
        parse_realty(realty)
      end
    end

    def parse_realty(realty)
      tmp = {}

      mapper.each do |key, value|
        elem = realty.xpath(key.to_s)
        next if elem.empty?

        if key == :objektkategorie
          tmp[mapper[key]] = RealtyCategory.new(elem)
        else
          tmp[mapper[key]] = Justimmo::Utils.parse_value(elem.text)
        end
      end

      @attributes << tmp
    end
  end

  class RealtyDetailBuilder < RealtyBuilder
    def build
      Realty.new(@attributes)
    end

    private

    def parse(xml)
      @attributes = {}

      realty = xml.xpath('//immobilie')
      parse_realty(realty)
    end

    def parse_realty(realty)
      parse_category(realty.xpath('objektkategorie').first)
      parse_geo(realty.xpath('geo').first)
      parse_contact(realty.xpath('kontaktperson').first)
      parse_prices(realty.xpath('preise').first)
      parse_areas(realty.xpath('flaechen').first)
      parse_equipment(realty.xpath('ausstattung').first)
      # realty.xpath('zustand_angaben')
      # realty.xpath('freitexte')
      # realty.xpath('anhaenge')
      # realty.xpath('verwaltung_objekt')
      # realty.xpath('verwaltung_techn')
    end

    def parse_category(xml)
      @attributes[mapper[xml.name]] = RealtyCategory.new(xml)
    end

    def parse_geo(xml)
      @attributes[mapper[xml.name]] = RealtyGeo.new(xml)
    end

    def parse_contact(xml)
      @attributes[mapper[xml.name]] = RealtyContact.new(xml)
    end

    def parse_prices(xml)
      @attributes[mapper[xml.name]] = RealtyPrice.new(xml)
    end

    def parse_areas(xml)
      xml.children.each do |child|
        @attributes[mapper[child.name]] = Justimmo::Utils.parse_value(child.text)
      end
    end

    def parse_equipment(xml)
      @attributes[mapper[xml.name]] = {}
      xml.children.each do |child|
        @attributes[mapper[xml.name]].update(Justimmo::Utils.attributes_only(xml, child.name, mapper))
      end
    end
  end
end
