require "spec_helper"

RSpec.describe JustimmoClient::V1::EmployeeRequest do
  let(:base_url) { "#{JustimmoClient::Config.url}/team" }

  context "list" do
    let(:url) { "#{base_url}/list" }
    let(:employee_list_xml) { fixture("api/v1/employee_list.xml") }

    before do
      stub_request(:get, url)
        .to_return(body: employee_list_xml, status: 200)
    end

    it "can get a list of employees" do
      described_class.list

      expect(a_request(:get, url))
        .to have_been_made.once
    end

    it "returns a XML document" do
      expect(described_class.list).to eq(employee_list_xml)
    end
  end

  context "detail" do
    let(:url) { "#{base_url}/detail" }
    let(:realty_detail_xml) { fixture("api/v1/realty_detail.xml") }

    before do
      stub_request(:get, url)
        .with(query: { id: 123456 })
        .to_return(body: realty_detail_xml, status: 200)
    end

    it "can get details of an employee" do
      described_class.detail(123456)

      expect(a_request(:get, url)
        .with(query: { id: 123456 }))
        .to have_been_made.once
    end

    it "returns a XML document" do
      expect(described_class.detail(123456)).to eq(realty_detail_xml)
    end
  end

  context "ids" do
    let(:url) { "#{base_url}/ids"}
    let(:realty_ids_json) { fixture("api/v1/realty_ids.json") }

    before do
      stub_request(:get, url)
        .to_return(body: realty_ids_json, status: 200)
    end

    it "can get a list of employee ids" do
      described_class.ids

      expect(a_request(:get, url))
        .to have_been_made.once
    end

    it "returns a JSON document" do
      expect(described_class.ids).to eq(realty_ids_json)
    end
  end
end
