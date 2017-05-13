require 'justimmo/realty/realty_builder'
require 'justimmo/realty/realty_query'

module Justimmo
  class Realty
    def initialize(attributes)
      @attributes = attributes
      @attributes.keys.each do |key|
        define_singleton_method(key) { @attributes[key] }
      end
    end

    def to_h
      @attributes
    end

    def to_json
      @attributes.to_json
    end

    class << self
      def new_from_list(xml)
        RealtyListBuilder.new(self, xml).build
      end

      def new_from_detail(xml)
        RealtyDetailBuilder.new(self, xml).build
      end

      # queries
      def find(filter, **attributes)
        response = RealtyQuery.list(filter, attributes)
        new_from_list(response)
      end

      def ids(filter, **attributes)
        RealtyQuery.ids(filter, attributes)
      end

      def detail(object_id, **attributes)
        response = RealtyQuery.detail(object_id, **attributes)
        new_from_detail(response)
      end
    end
  end
end
