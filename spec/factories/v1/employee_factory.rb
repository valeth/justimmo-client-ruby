FactoryGirl.define do
  factory :employee, class: JustimmoClient::V1::Employee do
    factory :employee_detail do
      id          123456
      number      123
      first_name  "John"
      last_name   "Doe"
      salutation  "Dr."
      position    "Test Dummy"
      street      "Crashlane 66"
      zip_code    1234
      location    "Somewhere"
      website     "https://example.com"
      phone       "+43 1234 56789"
      email       "john.doe@testlab.net"

      association :attachments, factory: :employee_picture
    end

    factory :employee_list do
      sequence(:id, 123456)
      sequence(:number, 123)
      sequence(:first_name, ["John", "Jane", "Dan"].each)
      sequence(:last_name, ["Doe", "Doe", "Deff"].each)
      sequence(:salutation, ["Dr.", "", "Mag."].each)
      sequence(:phone, ["+43 1234 56789", "+43 1234 65879", "+43 1234 96587"].each)
      sequence(:email, ["john.doe", "jane.doe", "dan.deff"].each) { |n| "#{n}@testlab.net" }
      position "Test Dummy"
      street   "Crashlane 66"
      zip_code 1234
      location "Somewhere"
      website  "https://example.com"

      association :attachments, factory: :employee_picture
    end
  end

  factory :employee_picture, class: JustimmoClient::V1::Attachment do
    type   "pic"
    format "jpg"
    size   :user_big
    file   "nonexistent"
  end
end
