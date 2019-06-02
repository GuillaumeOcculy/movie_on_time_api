FactoryBot.define do
  factory :watchlist_movie do
    association :user
    association :movie
  end
end
