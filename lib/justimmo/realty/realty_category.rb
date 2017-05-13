require 'justimmo/realty/realty_mapper'
require 'justimmo/utils'
require 'nokogiri'

module Justimmo
  class RealtyCategory
    def initialize(xml)
      @attributes = {}

      parse(xml)

      @attributes.keys.each do |key|
        define_singleton_method(key) { @attributes[key] }
      end
    end

    private

    def parse(xml)
      @attributes.update(Justimmo::Utils.attributes_only(xml, 'nutzungsart', mapper))
      @attributes.update(Justimmo::Utils.attributes_only(xml, 'vermarktungsart', mapper))

      elem = xml.xpath('user_defined_simplefield')
      @attributes[:user_defined_simplefield] = Justimmo::Utils.attributes(elem, mapper)
    end

    def mapper
      Justimmo::RealtyMapper
    end
  end
end
