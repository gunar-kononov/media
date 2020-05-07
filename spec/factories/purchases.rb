FactoryBot.define do
  factory :purchase do
    user
    content
    price_cents { Faker::Number.number(digits: 3) }
    price_currency { 'EUR' }
    quality { Faker::Number.within(range: 0..1) }
  end
end
