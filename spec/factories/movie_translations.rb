FactoryBot.define do
  factory :movie_translation do
    title           { Faker::Book.title }
    synopsis        { Faker::Movie.quote }
    poster_url      { Faker::Internet.url('poster.com') }
    thumbnail_url   { Faker::Internet.url('thumbnail.com') }
    language        { ['fr', 'en'].sample }

    association :movie
  end
end
