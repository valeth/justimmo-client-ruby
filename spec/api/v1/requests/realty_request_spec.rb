require "spec_helper"

RSpec.describe JustimmoClient::V1::RealtyRequest do
  let(:base_url) { "#{JustimmoClient::Config.url}/objekt" }

  context "list" do
    let(:url) { "#{base_url}/list" }
    let(:realty_list_xml) { fixture("api/v1/realty_list.xml") }

    before do
      stub_request(:get, url)
        .to_return(body: realty_list_xml, status: 200)
    end

    it "can request a list of realties" do
      described_class.list
      expect(a_request(:get, url))
        .to have_been_made
    end

    it "returns a XML document" do
      expect(described_class.list).to eq(realty_list_xml)
    end
  end

  context "detail" do
    let(:url) { "#{base_url}/detail" }
    let(:realty_detail_xml) { fixture("api/v1/realty_detail.xml") }

    before do
      stub_request(:get, url)
        .with(query: { objekt_id: 123456 })
        .to_return(body: realty_detail_xml, status: 200)

      stub_request(:get, url)
        .with(query: { objekt_id: 123456, culture: :en })
        .to_return(body: realty_detail_xml, status: 200)
    end

    it "can request realty details" do
      described_class.detail(123456)
      expect(a_request(:get, url)
        .with(query: { objekt_id: 123456 }))
        .to have_been_made
    end

    it "can request realty details with language" do
      described_class.detail(123456, lang: :en)
      expect(a_request(:get, url)
        .with(query: { objekt_id: 123456, culture: :en }))
        .to have_been_made
    end

    it "returns a XML document" do
      expect(described_class.detail(123456)).to eq(realty_detail_xml)
    end
  end

  context "ids" do
    let(:url) { "#{base_url}/ids" }
    let(:realty_ids_json) { fixture("api/v1/realty_ids.json") }

    before do
      stub_request(:get, url)
        .to_return(body: realty_ids_json, status: 200)
    end

    it "can request realty ids" do
      described_class.ids
      expect(a_request(:get, url))
        .to have_been_made
    end

    it "returns a JSON document" do
      expect(described_class.ids).to eq(realty_ids_json)
    end
  end

  context "inquiry"

  context "expose"

  context "categories"

  context "types"

  context "countries"

  context "federal_states"

  context "regions"

  context "zip_codes_and_cities"
end
