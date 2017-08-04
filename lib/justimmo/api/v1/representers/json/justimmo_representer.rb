# frozen_string_literal: true

require "roar/decorator"
require "roar/json"
require "roar/coercion"

module Justimmo
  module V1
    module JSON
      class JustimmoRepresenter < Roar::Decorator
        include Roar::JSON
        include Roar::Coercion

        defaults render_nil: true
      end
    end
  end
end
