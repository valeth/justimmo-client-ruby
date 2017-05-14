require 'justimmo/employee/employee_mapper'
require 'justimmo/utils'
require 'nokogiri'

module Justimmo
  class RealtyContact
    def initialize(xml)
      @attributes = {}

      parse(xml)

      @attributes.keys.each do |key|
        define_singleton_method(key) { @attributes[key] }
      end
    end

    private

    def parse(xml)
      @attributes.update(Justimmo::Utils.attributes_only(xml, 'land', mapper))

      elem = xml.xpath('bild').first
      @attributes[mapper[elem.name]] =
        elem.children.reduce({}) do |acc, child|
          acc.update(child.name.to_sym => Justimmo::Utils.parse_value(child.text))
        end

      xml.children.each do |child|
        next if %i[user_defined_anyfield bild land].include?(child.name)

        @attributes[mapper[child.name]] = Justimmo::Utils.parse_value(child.text)
      end
    end

    def mapper
      Justimmo::EmployeeMapper
    end
  end
end
