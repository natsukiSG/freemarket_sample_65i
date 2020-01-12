FactoryBot.define do
  factory :product do
    name                      {"yuta"}
    comment                   {"comment"}
    price                     {Faker::Number.number(digits: 7)}
    status                    {1}
    costcharge                {1}
    delivery_way              {"〇〇便"}
    delivery_area             {"東京都"}
    delivery_date             {"〇〇で発送"}
    category_id               {Faker::Number.number(digits: 3)}
  end
end
