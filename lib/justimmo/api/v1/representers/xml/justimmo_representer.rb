# frozen_string_literal: true

require "representable/xml"
require "representable/coercion"

module Justimmo::V1
  module XML
    class JustimmoRepresenter < Representable::Decorator
      include Representable::XML
      include Representable::Coercion

      defaults render_nil: true
    end
  end
end
