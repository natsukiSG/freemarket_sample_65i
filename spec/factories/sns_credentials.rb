FactoryBot.define do
  factory :sns_credential do
    uid                          {Faker::Number.number(digits: 15)}
    provider                     {"google"}
  end
end
