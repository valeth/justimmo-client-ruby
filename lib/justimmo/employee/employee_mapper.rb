require 'justimmo/mapper'

module Justimmo
  module EmployeeMapper
    extend Justimmo::Mapper

    @mapping = {
      id:                :id,
      kategorie:         :category,
      anhang:            :attachments,
      vorname:           :first_name,
      nachname:          :last_name,
      name:              :last_name,
      tel_zentrale:      :phone,
      email_direkt:      :email,
      position:          :postition, # ?
      handy:             :mobile,
      tel_handy:         :mobile,
      tel_fax:           :fax,
      titel:             :title,
      suffix:            :suffix,
      bio:               :biography,
      personennummer:    :number,
      strasse:           :street,
      plz:               :postal,
      ort:               :city,
      url:               :url,

      anrede:            :salutation,
      firma:             :company,
      email_feedback:    :email_feedback,
      bild:              :picture,
      land:              :country,
      iso_land:          :iso_country
    }.freeze
  end
end
