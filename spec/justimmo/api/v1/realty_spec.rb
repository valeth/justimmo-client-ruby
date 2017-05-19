# require 'spec_helper'
#
# RSpec.describe Justimmo::Realty do
#   DEFAULT_OPTIONS = {
#     id: 1, number: 1, category: 0,
#     title: 'title', description: 'desc', price: 1.1,
#     zip_code: 1000, location: 'place', status_id: 1,
#     pictures: []
#   }.freeze
#
#   it 'has default attributes' do
#     realty = Justimmo::Realty.new
#
#     expect(realty).to respond_to(
#       :id, :number, :category,
#       :title, :teaser, :proximity,
#       :description, :room_count, :tiers,
#       :location, :zip_code, :price,
#       :living_area, :surface_area, :pictures,
#       :status_id, :purcase_price
#     )
#   end
# end
