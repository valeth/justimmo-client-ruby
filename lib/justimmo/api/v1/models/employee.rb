# frozen_string_literal: true

module Justimmo::V1
  class Employee < JustimmoBase
    attribute :id, Integer
    attribute :number, Integer
    attribute :email
    attribute :phone
    attribute :phone_mobile
    attribute :last_name
    attribute :first_name
    attribute :salutation
    attribute :company
    attribute :street
    attribute :zip_code, Integer
    attribute :location
    attribute :email_feedback
    attribute :website
    attribute :picture, Image
    attribute :attachment, Image

    def full_name(surname_first: false, with_salutation: true)
      name = [first_name, last_name]
      name.reverse! if surname_first
      name.unshift(salutation) if with_salutation
      name.join(" ")
    end

    def inspect
      "#<#{self.class.name} #{full_name}>"
    end
  end
end
