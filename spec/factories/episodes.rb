FactoryBot.define do
  factory :episode do
    title { Faker::Lorem.sentence.chomp('.') }
    plot { Faker::Lorem.paragraph }
    index { 1 }
  end
end
