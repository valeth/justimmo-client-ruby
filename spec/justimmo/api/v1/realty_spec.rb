require 'spec_helper'

RSpec.describe Justimmo::API::Realty do
  it 'can create an empty realty' do
    expect { Justimmo::API::Realty.new }.not_to raise_error
  end

  it 'can be serialized to JSON format' do
    realty = Justimmo::API::Realty.new
    json = realty.to_json
    realty_from_json = Justimmo::API::Realty.from_json(json)

    expect(realty.to_h).to eq(realty_from_json.to_h)
  end
end
