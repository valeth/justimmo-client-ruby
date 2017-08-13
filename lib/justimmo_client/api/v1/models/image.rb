# frozen_string_literal: true

module JustimmoClient::V1
  class Image < File
    def initialize(**options)
      super(options)
      @type = :pic
    end
  end
end
