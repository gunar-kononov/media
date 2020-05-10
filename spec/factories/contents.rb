FactoryBot.define do
  factory :content do
    factory :movie_content do
      media factory: :movie
      purchasable { true }
    end

    factory :season_content do
      media factory: :season
      purchasable { true }

      factory :season_content_with_episodes do
        transient do
          episode_count { 1 }
        end

        after(:create) do |season_content, evaluator|
          create_list(:episode_content, evaluator.episode_count, parent: season_content)
        end
      end
    end

    factory :episode_content do
      media factory: :episode
      parent factory: :season_content
      purchasable { false }
    end

    factory :purchasable_content do
      media { create [:movie, :season].sample }
      purchasable { true }
    end

    factory :non_purchasable_content do
      media factory: :episode
      purchasable { false }
    end
  end
end
