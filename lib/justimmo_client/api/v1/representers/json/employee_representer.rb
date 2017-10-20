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

      property :picture, class: Image do
        %i[small medium big pfad_medium].each do |size|
          property size,
            setter: ->(represented:, fragment:, **) { represented.add_url(fragment, default: :user_big) },
            getter: ->(represented:, **) { represented[size] }
        end
      end

      collection_representer class: Employee
    end
  end
end
