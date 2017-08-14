# frozen_string_literal: true

require "representable/json"

module JustimmoClient::V1
  module JSON
    class JustimmoRepresenter < Representable::Decorator
      include Representable::JSON

      defaults render_nil: true
    end
  end
end
