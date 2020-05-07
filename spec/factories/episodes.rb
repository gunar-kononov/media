FactoryBot.define do
  factory :episode do
    title { Faker::Lorem.sentence.chomp('.') }
    plot { Faker::Lorem.paragraph }
    index { Faker::Number.within(range: 1..10) }
  end
end
