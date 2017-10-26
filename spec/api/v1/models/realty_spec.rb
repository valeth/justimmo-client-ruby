require "spec_helper"

RSpec.describe JustimmoClient::V1::Realty do
  let(:model) { JustimmoClient::V1::Realty.new }
  let(:xml_representer) { JustimmoClient::V1::XML::RealtyRepresenter }
  let(:json_representer) { JustimmoClient::V1::JSON::RealtyRepresenter }

  context "detail" do
    let(:realty) { build :realty, id: 123456, number: 123 }
    let(:xml) { fixture("api/v1/realty_detail.xml") }
    let(:represented) do
      xml_representer.for_collection.new([]).from_xml(xml).first
    end

    it "can represent detailed information" do
      expect(represented).to eq(realty)
    end

    it "can be JSON serialized" do
      json = json_representer.new(represented).to_json
      converted = json_representer.new(model).from_json(json)
      expect(converted).to eq(realty)
    end
  end

  context "list" do
    let(:realties) { build_list(:realty_list, 3) }
    let(:xml) { fixture("api/v1/realty_list.xml") }
    let(:represented) do
      xml_representer.for_collection.new([]).from_xml(xml)[1..-1]
    end

    it "can represent a list with basic information" do
      expect(represented).to eq(realties)
    end

    it "can be JSON serialized" do
      json = json_representer.for_collection.new(represented).to_json
      converted = json_representer.for_collection.new([]).from_json(json)
      expect(converted).to eq(represented)
    end
  end
end
