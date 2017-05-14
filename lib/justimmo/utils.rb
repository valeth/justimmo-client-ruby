require 'active_support'
require 'active_support/core_ext'

module Justimmo
  module Utils
    class XMLBuilder
      attr_reader :attributes

      def initialize(klass, xml)
        @attributes = []
        @klass = klass

        xml = Nokogiri::XML(xml) do |config|
          config.noblanks
          config.recover
          config.nonet
        end

        parse(xml)
      end

      def build
        Logger.debug("Building new object of type #{@klass}")
        @attributes.map do |elem|
          @klass.new(elem)
        end
      end

      private

      def parse; end
      def mapper; end
    end

    class << self
      def parse_value(value)
        case value
        when /^\d*\.\d+$/ then value.to_f
        when /^\d+$/      then value.to_i
        when 'true'       then true
        when 'false'      then false
        when /^\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}$/ then value.to_date
        else
          value.respond_to?(:to_s) ? value.gsub("\r\n", "\n") : value
        end
      end

      def attributes_only(xml, path, mapper)
        elem = xml.xpath(path).first
        tmp =
          elem.attributes.values.reduce({}) do |acc, attribute|
            name  = attribute.name
            value = parse_value(attribute.value)
            acc.update(mapper[name] => value)
          end
        { mapper[elem.name] => tmp.select { |_k, v| v == 1 }.keys.first }
      end

      def attributes(xml, mapper)
        xml.reduce({}) do |acc, elem|
          name  = elem.attributes.values.first.value
          value = parse_value(elem.text)
          acc.update(mapper[name] => value)
        end
      end
    end
  end
end
