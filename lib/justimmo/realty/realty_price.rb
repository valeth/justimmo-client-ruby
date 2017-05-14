require 'justimmo/realty/realty_mapper'
require 'justimmo/utils'
require 'nokogiri'

module Justimmo
  class RealtyPrice
    def initialize(xml)
      @attributes = {}

      parse(xml)

      @attributes.keys.each do |key|
        define_singleton_method(key) { @attributes[key] }
      end
    end

    private

    def parse(xml)
      elem = xml.xpath('miete').first

      unless elem.nil?
        @attributes[mapper[elem.name]] =
          elem.children.reduce({}) do |acc, child|
            acc.update(mapper[child.name] => Justimmo::Utils.parse_value(child.text))
          end
      end

      elem = xml.xpath('zusatzkosten').first
      unless elem.nil?
        tmp = elem.children.reduce({}) do |acc, child|
          tmp2 = child.children.reduce({}) do |acc2, child2|
            acc2.update(mapper[child2.name] => Justimmo::Utils.parse_value(child2.text))
          end
          acc.update(mapper[child.name] => tmp2)
        end

        @attributes[mapper[elem.name]] = tmp
      end

      xml.children.each do |child|
        next if %i[miete zusatzkosten].include?(child.name)

        @attributes[mapper[child.name]] = Justimmo::Utils.parse_value(child.text)
      end
    end

    def mapper
      Justimmo::RealtyMapper
    end
  end
end
