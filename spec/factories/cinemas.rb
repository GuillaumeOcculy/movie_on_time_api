FactoryBot.define do
  factory :cinema do
    external_id         { Faker::Internet.password }
    name                { Faker::Book.title }
    city                { ['Paris', 'Lyon', 'Marseille'].sample }
    country_code        { 'FR' }

    association :chain
    association :country

    trait :france do
      country_code 'FR'
    end

    trait :england do
      country_code 'GB'
    end
  end
end
