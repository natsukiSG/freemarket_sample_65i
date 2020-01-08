FactoryBot.define do
  factory :street_address do
    address_last_name              {"abe"}
    address_first_name             {"fff"}
    address_last_name_kana         {"aaa"}
    address_first_name_kana        {"ddd"}
    post_number                    {Faker::Number.number(digits: 7)}
    prefectures                    {"東京都"}
    city                           {"区"}
    house_number                   {"00"}
  end
end
