# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class AttachmentRepresenter < JustimmoRepresenter
      property :category
      property :origin
      property :title
      property :url

      collection_representer class: Attachment
    end
  end
end
