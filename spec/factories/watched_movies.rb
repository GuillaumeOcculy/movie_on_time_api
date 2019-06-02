FactoryBot.define do
  factory :watched_movie do
    watched_date        { Faker::Date.between(2.days.ago, Date.today) }

    association :user
    association :movie
  end
end
