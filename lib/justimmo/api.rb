# frozen_string_literal: true

module Justimmo
  # @api private
  module API
    autoload :Mapper,       'justimmo/api/v1/mapper'
    autoload :Query,        'justimmo/api/v1/query'
    autoload :RealtyMapper, 'justimmo/api/v1/realty_mapper'
    autoload :RealtyQuery,  'justimmo/api/v1/realty_query'
    autoload :Resource,     'justimmo/api/v1/resource'

    autoload :RealtyArea,       'justimmo/api/v1/realty/realty_area'
    autoload :RealtyAttachment, 'justimmo/api/v1/realty/realty_attachment'
    autoload :RealtyCategory,   'justimmo/api/v1/realty/realty_category'
    autoload :RealtyContact,    'justimmo/api/v1/realty/realty_contact'
    autoload :RealtyFreeText,   'justimmo/api/v1/realty/realty_free_text'
    autoload :RealtyGeo,        'justimmo/api/v1/realty/realty_geo'
    autoload :RealtyManagement, 'justimmo/api/v1/realty/realty_management'
    autoload :RealtyPrice,      'justimmo/api/v1/realty/realty_price'
    autoload :RealtyTechnical,  'justimmo/api/v1/realty/realty_technical'

    autoload :Realty,   'justimmo/api/v1/realty'
    autoload :Employee, 'justimmo/api/v1/employee'
  end
end
