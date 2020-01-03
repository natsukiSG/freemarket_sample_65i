FactoryBot.define do
  factory :creditcard do
    card_id                          {Faker::Number.number(digits: 30)}
    customer_id                      {Faker::Number.number(digits: 30)}
  end
end
