FactoryBot.define do
  factory :cinema do
    external_id         { Faker::Internet.password }
    name                { Faker::Book.title }
    city                { ['Paris', 'Lyon', 'Marseille'].sample }
    country_code        { 'FR' }

    association :chain
    association :country
  end
end
