FactoryGirl.define do
  factory :realty, class: JustimmoClient::V1::Realty do
    title       "Test object"
    teaser      ["point one", "point two", "point three"]
    description "<p>Just a test object description.</p>"
    type_id     5
    sub_type_id 11
    status_id   5
    created_at  DateTime.parse("2017-01-01 00:00:00")
    updated_at  DateTime.parse("2017-01-10 00:00:00")

    association :contact,     factory: :employee
    association :usage,       factory: :realty_usage
    association :marketing,   factory: :realty_marketing
    association :geo,         factory: :realty_geo
    association :area,        factory: :realty_area
    association :room_count,  factory: :realty_room_count
    association :price,       factory: :realty_price

    factory :realty_list do
      sequence(:id, 123456)
      sequence(:number, 123)
      association :geo,
        factory: :realty_geo,
        federal_state: nil,
        country: nil,
        longitude: nil,
        latitude: nil
    end
  end

  factory :realty_usage, class: JustimmoClient::V1::RealtyUsage do
    living     true
    business   false
    investment false
  end

  factory :realty_marketing, class: JustimmoClient::V1::RealtyMarketing do
    buy  true
    rent false
  end

  factory :realty_geo, class: JustimmoClient::V1::GeoLocation do
    federal_state "Some State"
    country       "Austria"
    zip_code      1234
    longitude     1.2345678
    latitude      8.7654321
    location      "Some Place"
  end

  factory :realty_area, class: JustimmoClient::V1::RealtyArea do
  end

  factory :realty_room_count, class: JustimmoClient::V1::RealtyRoomCount do
  end

  factory :realty_price, class: JustimmoClient::V1::RealtyPrice do
  end
end
