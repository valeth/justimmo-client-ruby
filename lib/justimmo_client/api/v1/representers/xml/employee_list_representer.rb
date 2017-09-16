# frozen_string_literal: true

module JustimmoClient::V1
  module XML
    class EmployeeListRepresenter < JustimmoRepresenter
      nested :kategorie do
        collection :employees,
          as: :mitarbeiter,
          wraps: :mitarbeiter,
          class: Employee,
          decorator: EmployeeRepresenter
      end
    end
  end
end
