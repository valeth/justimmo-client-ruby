# frozen_string_literal: true

module JustimmoClient::V1
  class Employee < JustimmoBase
    attribute :id,          Integer
    attribute :number,      Integer
    attribute :email,       String
    attribute :phone,       String
    attribute :mobile,      String
    attribute :fax,         String
    attribute :last_name,   String
    attribute :first_name,  String
    attribute :salutation,  String
    attribute :company,     String
    attribute :street,      String
    attribute :zip_code,    Integer
    attribute :location,    String
    attribute :email_feedback, String
    attribute :website,     String
    attribute :picture,     Image
    attribute :attachment,  Image
    attribute :position,    String

    def full_name(surname_first: false, with_salutation: true)
      name = [first_name, last_name]
      name.reverse! if surname_first
      name.unshift(salutation) if with_salutation
      name.compact.join(" ")
    end

    def to_s
      full_name
    end

    def inspect
      "#<#{self.class} #{self}>"
    end
  end
end
