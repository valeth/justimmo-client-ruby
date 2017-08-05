# frozen_string_literal: true

require "roar/decorator"
require "roar/json"

module Justimmo
  module V1
    module JSON
      class JustimmoRepresenter < Roar::Decorator
        include Roar::JSON

        defaults render_nil: true
      end
    end
  end
end
