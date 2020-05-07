FactoryBot.define do
  factory :movie do
    title { Faker::Lorem.sentence.chomp('.') }
    plot { Faker::Lorem.paragraph }
  end
end
