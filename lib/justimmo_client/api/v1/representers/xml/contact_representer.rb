# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class ContactRepresenter < EmployeeRepresenter
      property :email_feedback
      property :email, as: :email_direkt
      property :last_name, as: :name
      property :company, as: :firma
      property :salutation, as: :anrede
      property :phone, as: :tel_zentrale
      property :mobile, as: :tel_handy
    end
  end
end
