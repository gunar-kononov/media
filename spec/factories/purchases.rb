FactoryBot.define do
  factory :purchase do
    user
    content
    price_cents { 0 }
    price_currency { 'EUR' }
    quality { 0 }
  end
end
