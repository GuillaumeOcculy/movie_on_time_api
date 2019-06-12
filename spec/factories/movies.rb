FactoryBot.define do
  factory :movie do
    external_id         { Faker::Internet.password }
    original_title      { Faker::Book.title }
    original_language   { 'fr' }
    running_time        { [90, 120, 160, 180].sample }

    trait :with_french_release do
      after(:create) do |movie|
        create :movie_country, release_date: Date.today, movie: movie
      end
    end

    trait :with_showtimes do
      after(:create) do |movie|
        create_list :showtime, 3, start_date: Date.tomorrow, movie: movie
      end
    end

    trait :with_old_showtimes do
      after(:create) do |movie|
        create_list :showtime, 3, start_date: Date.yesterday, movie: movie
      end
    end

    trait :with_translations do
      after(:create) do |movie|
        create :movie_translation, language: 'fr', movie: movie
        create :movie_translation, language: 'en', movie: movie
      end
    end

    trait :with_no_images do
      after(:create) do |movie|
        create :movie_translation, poster_url: nil, language: 'fr', movie: movie
        create :movie_translation, poster_url: nil, language: 'en', movie: movie
      end
    end
  end
end
