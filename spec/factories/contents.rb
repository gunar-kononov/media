FactoryBot.define do
  factory :content do
    purchasable { false }

    factory :movie_content do
      media factory: :movie
      purchasable { true }
    end

    factory :season_content do
      media factory: :season
      purchasable { true }
    end

    factory :episode_content do
      media factory: :episode
      parent_content factory: :season_content
    end
  end
end
