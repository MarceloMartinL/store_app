FactoryBot.define do
  factory :product do
    name { Faker::Food.dish }
    sequence(:sku) { |n| "sku_#{n}" }
    type { 'pizza' }
    price { Faker::Number.between(from: 1000, to: 100000) }
  end
end
