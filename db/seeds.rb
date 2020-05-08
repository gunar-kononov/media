user = User.create!(email: Faker::Internet.safe_email)

Array.new(20).map do
  Content.create!(
      media: Movie.create!(
          title: Faker::Lorem.sentence.chomp('.'),
          plot: Faker::Lorem.paragraph
      ),
      purchasable: true
  )
end

Array.new(20).each_with_index.map do |_, s|
  Content.create!(
      media: Season.create!(
          title: Faker::Lorem.sentence.chomp('.'),
          plot: Faker::Lorem.paragraph,
          index: s + 1
      ),
      purchasable: true,
      children: Array.new(10).each_with_index.map do |_, e|
        Content.create!(
            media: Episode.create!(
                title: Faker::Lorem.sentence.chomp('.'),
                plot: Faker::Lorem.paragraph,
                index: e + 1
            ),
            purchasable: false
        )
      end
  )
end

Purchase.create!(
    [
        { user: user, content: Content.movies.first, price_cents: 299, price_currency: 'EUR', quality: :hd },
        { user: user, content: Content.seasons.first, price_cents: 299, price_currency: 'EUR', quality: :sd }
    ]
)
