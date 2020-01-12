FactoryBot.define do

  factory :user do
    nickname              {"abe"}
    email                 {Faker::Internet.email}
    password              {"00000000"}
    password_confirmation {"00000000"}
    first_name            {"竃門"}
    last_name             {"炭次郎"}
    first_name_kana       {"かまど"}
    last_name_kana         {"たんじろう"}
    birth_year            {"1989"}
    birth_month           {"9"}
    birth_day             {"27"}
    phone_number          {Faker::Number.number(digits: 11)}
  end

end