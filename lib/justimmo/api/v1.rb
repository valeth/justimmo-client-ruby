# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

module Justimmo
  module V1
    API_PATH = "#{__dir__}/v1"
    MOD_PATH = "#{API_PATH}/models"
    MODELS = Dir["#{MOD_PATH}/*.rb"].reject { |e| /.*base/ =~ e }.map { |e| File.basename(e, ".rb") }

    private_constant :API_PATH
    private_constant :MOD_PATH
    private_constant :MODELS

    MODELS.each do |f|
      autoload f.classify, "#{MOD_PATH}/#{f}"
    end

    module XML
      XML_REP_PATH = "#{API_PATH}/representers/xml"

      private_constant :XML_REP_PATH

      MODELS.each do |f|
        autoload "#{f.classify}Representer", "#{XML_REP_PATH}/#{f}_representer"
      end
    end

    module JSON
      JSON_REP_PATH = "#{API_PATH}/representers/json"

      private_constant :JSON_REP_PATH

      MODELS.each do |f|
        autoload "#{f.classify}Representer", "#{JSON_REP_PATH}/#{f}_representer"
      end
    end
  end
end
