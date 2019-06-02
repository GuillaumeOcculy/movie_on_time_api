FactoryBot.define do
  factory :movie_country do
    release_date    { Faker::Date.between(2.days.ago, Date.tomorrow) }
    iso_code        { 'FR' }

    association :movie
    association :country
  end
end
