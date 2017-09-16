require "spec_helper"

describe "JustimmoClient::V1::Employee" do
  let(:employee) do
    JustimmoClient::V1::Employee.new({
      id:         "123456",
      number:     "1",
      first_name: "John",
      last_name:  "Doe",
      salutation: "Mr.",
      zip_code:   "1234"
    })
  end

  it "has valid attributes" do
    expect(employee).to have_attributes(
      id:             be_an(Integer),
      number:         be_an(Integer),
      first_name:     "John",
      last_name:      "Doe",
      email:          be_nil,
      phone:          be_nil,
      mobile:         be_nil,
      fax:            be_nil,
      salutation:     "Mr.",
      company:        be_nil,
      street:         be_nil,
      zip_code:       be_an(Integer),
      location:       be_nil,
      email_feedback: be_nil,
      website:        be_nil,
      picture:        be_nil,
      attachment:     be_nil,
      position:       be_nil
    )
  end

  it "can display the full name" do
    expect(employee.full_name).to eq("Mr. John Doe")
    expect(employee.full_name surname_first: true).to eq("Mr. Doe John")
    expect(employee.full_name with_salutation: false).to eq("John Doe")
    expect(employee.full_name surname_first: true, with_salutation: false).to eq("Doe John")
  end
end
