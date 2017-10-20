# frozen_string_literal: true

module JustimmoClient::V1
  module JSON
    class ContactRepresenter < EmployeeRepresenter
      property :email_feedback
      property :email
      property :last_name
      property :company
      property :salutation
      property :phone
      property :mobile
    end
  end
end
