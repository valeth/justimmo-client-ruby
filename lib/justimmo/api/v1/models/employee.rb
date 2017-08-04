# frozen_string_literal: true

require_relative "base"

module Justimmo
  module V1
    class Employee < Base
      attr_accessor :id, :number, :email, :phone, :phone_mobile,
                    :last_name, :first_name, :salutation, :company,
                    :street, :zip_code, :location, :email_feedback,
                    :website, :picture, :attachment

      def full_name(surname_first: false, with_salutation: true)
        name = [first_name, last_name]
        name.reverse! if surname_first
        name.unshift(salutation) if with_salutation
        name.join(" ")
      end
    end
  end
end
