FactoryBot.define do
  factory :favorite_cinema do
    association :user
    association :cinema
  end
end
