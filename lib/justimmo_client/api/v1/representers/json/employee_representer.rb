# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class EmployeeRepresenter < JustimmoRepresenter
      property :id
      property :number
      property :first_name
      property :last_name
      property :salutation
      property :position
      property :phone
      property :mobile
      property :fax
      property :email
      property :street
      property :zip_code
      property :location
      property :website

      property :email_feedback
      property :email
      property :last_name
      property :company
      property :salutation
      property :phone
      property :mobile

      collection :attachments,
        decorator: AttachmentRepresenter,
        class: Attachment

      collection_representer class: Employee
    end
  end
end
