# frozen_string_literal: true

require "representable/xml"

module JustimmoClient::V1
  module XML
    class JustimmoRepresenter < Representable::Decorator
      include Representable::XML

      defaults render_nil: true
    end
  end
end
