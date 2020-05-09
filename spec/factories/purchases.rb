FactoryBot.define do
  factory :purchase do
    user
    content factory: :purchasable_content
    price { Faker::Number.decimal(l_digits: 2, r_digits: 2) }
    price_currency { Faker::Currency.code }
    quality { Purchase.qualities.keys.sample }

    factory :expired_purchase do
      created_at { (Purchase::EXPIRATION_DAYS + 1).days.ago }
      updated_at { (Purchase::EXPIRATION_DAYS + 1).days.ago }
    end
  end
end
