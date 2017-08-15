require "spec_helper"

describe "JustimmoClient::V1::Realty" do
  let(:realty) do
    JustimmoClient::V1::Realty.new({
      id:           "100000",
      number:       "100",
      title:        "Title",
      teaser:       "",
      description:  "<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\nTest description &amp; HTML excapes",
      type_id:      "5",
      created_at:   "01-01-2017",
      updated_at:   "01-10-2017"
    })
  end

  it "has valid attributes" do
    expect(realty).to have_attributes(
      id:           be_an(Integer),
      number:       be_an(Integer),
      title:        be_a(String),
      description:  "Test description &amp; HTML excapes",
      teaser:       "<ul>\n<li>one</li>\n<li>two</li>\n<li>three</li>\n</ul>\n",
      usage:        be_a(JustimmoClient::V1::RealtyUsage),
      marketing:    be_a(JustimmoClient::V1::RealtyMarketing),
      type_id:      be_an(Integer),
      sub_type_id:  be_nil,
      geo:          be_a(JustimmoClient::V1::GeoLocation),
      area:         be_a(JustimmoClient::V1::RealtyArea),
      room_count:   be_a(JustimmoClient::V1::RealtyRoomCount),
      price:        be_a(JustimmoClient::V1::RealtyPrice),
      status_id:    be_nil,
      floor:        be_nil,
      openimmo_id:  be_nil,
      contact:      be_nil,
      description_furniture:  be_an(Array),
      furniture:    be_an(Array),
      images:       be_an(Array),
      documents:    be_an(Array),
      videos:       be_an(Array),
      images360:    be_an(Array),
      links:        be_an(Array),
      available:    be_nil,
      created_at:   be_a(DateTime),
      updated_at:   be_a(DateTime)
    )
  end


end
