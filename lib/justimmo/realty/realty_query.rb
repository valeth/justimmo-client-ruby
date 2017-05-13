require 'justimmo/request'
require 'justimmo/realty/realty_mapper'
require 'json'

module Justimmo
  module RealtyQuery
    class << self
      def list(filter, **attributes)
        params = update_params(attributes)
        params[:filter] = update_filter(filter)

        Justimmo::Request.get('objekt/list', params)
      end

      def detail(id, **attributes)
        params = update_params(attributes.update(realty_id: id))

        Justimmo::Request.get('objekt/detail', params)
      end

      def expose(id, expose: nil, language: nil)
        # Justimmo::Request.get('objekt/expose', params)
      end

      def inquiry(attributes)
        # Justimmo::Request.get('objekt/anfrage', params)
      end

      def ids(filter, **attributes)
        params = update_params(attributes)
        params[:filter] = update_filter(filter)

        response = Justimmo::Request.get('objekt/ids', params)
        JSON.parse(response).map { |x| Justimmo::Utils.parse_value(x) }
      end
    end

    module_function

    def update_filter(filter)
      filter.reduce({}) do |acc, (key, value)|
        acc.update(mapper[key, map: :filter] => value)
      end
    end

    def update_params(params)
      params.reduce({}) do |acc, (key, value)|
        acc.update(mapper[key, map: :params] => value)
      end
    end

    def mapper
      Justimmo::RealtyMapper
    end
  end
end
