require 'spec_helper'

RSpec.describe Justimmo::API::Query do
end

RSpec.describe Justimmo::API::RealtyQuery do
  Mapper = Justimmo::API::RealtyMapper
  Mapper.on_mapper_error(:mark)
  RealtyQuery = Justimmo::API::RealtyQuery

  it 'builds list query parameters' do
    params = {
      limit: 5,
      language: 'de',
      orderby: :price,
      order: :asc,
      picturesize: :small,
      all: true,
      filter: { zip_code: 6800 }
    }.freeze

    out = {
      Limit: 5,
      culture: 'de',
      orderby: :preis,
      ordertype: :asc,
      picturesize: :small,
      alleProjektObjekte: 1,
      filter: { plz: 6800 }
    }.freeze

    expect(RealtyQuery.build_params(params)).to eq(out)
  end

  it 'builds detail query parameters' do
    params = {
      realty_id: 123_456,
      language: 'de'
    }.freeze

    out = {
      objekt_id: 123_456,
      culture: 'de'
    }.freeze

    expect(RealtyQuery.build_params(params)).to eq(out)
  end

  it 'builds expose query parameters' do
    params = {
      realty_id: 123_456,
      expose: 'Default',
      language: 'de'
    }.freeze

    out = {
      objekt_id: 123_456,
      expose: 'Default',
      culture: 'de'
    }.freeze

    expect(RealtyQuery.build_params(params)).to eq(out)
  end

  it 'builds inquiry query parameters' do
    params = {
      realty_id: 123_456,
      salutation_id: 1,
      title: 'BMst.',
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@doe.com',
      phone: '+1 123456',
      message: 'hello',
      street: 'Somewhere 1a',
      zip_code: 1234,
      location: 'Someplace',
      country: 'On Earth'
    }.freeze

    out = {
      objekt_id: 123_456,
      anrede_id: 1,
      titel: 'BMst.',
      vorname: 'John',
      nachname: 'Doe',
      email: 'john@doe.com',
      tel: '+1 123456',
      message: 'hello',
      strasse: 'Somewhere 1a',
      plz: 1234,
      ort: 'Someplace',
      land: 'On Earth'
    }.freeze

    expect(RealtyQuery.build_params(params)).to eq(out)
  end
end
