require "spec_helper"

RSpec.describe JustimmoClient::V1::Employee do
  let(:model)     { JustimmoClient::V1::Employee.new }
  let(:json_repr) { JustimmoClient::V1::JSON::EmployeeRepresenter }

  context "detail" do
    let(:xml) { fixture("api/v1/employee_detail.xml") }
    let(:xml_representer) { JustimmoClient::V1::XML::EmployeeRepresenter }
    let(:employee) { build(:employee_detail) }
    let(:represented) do
      xml_representer.new(model).from_xml(xml)
    end

    it "represents detailed employee information" do
      expect(represented).to eq(employee)
    end

    it "can be JSON serialized" do
      json = json_repr.new(represented).to_json
      converted = json_repr.new(model).from_json(json)
      expect(converted).to eq(represented)
    end
  end

  context "list" do
    let(:xml) { fixture("api/v1/employee_list.xml") }
    let(:xml_representer) { JustimmoClient::V1::XML::EmployeeListRepresenter }
    let(:employees) { build_list(:employee_list, 3) }
    let(:represented) do
      xml_representer.new(Struct.new(:employees).new).from_xml(xml).employees
    end

    it "represents a list of employees" do
      expect(represented).to eq(employees)
    end

    it "can be JSON serialized" do
      json = json_repr.for_collection.new(represented).to_json
      converted = json_repr.for_collection.new([]).from_json(json)
      expect(converted).to eq(represented)
    end
  end
end
