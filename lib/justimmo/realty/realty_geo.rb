require 'justimmo/realty/realty_mapper'
require 'justimmo/utils'
require 'nokogiri'

module Justimmo
  class RealtyGeo
    def initialize(xml)
      @attributes = {}

      parse(xml)

      @attributes.keys.each do |key|
        define_singleton_method(key) { @attributes[key] }
      end
    end

    private

    def parse(xml)
      elem = xml.xpath('user_defined_simplefield')
      @attributes[:user_defined_simplefield] = Justimmo::Utils.attributes(elem, mapper)

      xml.children.each do |child|
        next if child.name == 'user_defined_simplefield'
        @attributes[mapper[child.name]] = Justimmo::Utils.parse_value(child.text)
      end
    end

    def mapper
      Justimmo::RealtyMapper
    end
  end
end
