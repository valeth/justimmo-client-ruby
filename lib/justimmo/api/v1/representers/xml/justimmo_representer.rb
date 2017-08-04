# frozen_string_literal: true

require "roar/decorator"
require "roar/xml"
require "roar/coercion"

module Justimmo
  module V1
    module XML
      class JustimmoRepresenter < Roar::Decorator
        include Roar::XML
        include Roar::Coercion

        defaults render_nil: true
      end
    end
  end
end
