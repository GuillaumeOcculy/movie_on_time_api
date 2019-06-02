FactoryBot.define do
  factory :city do
    external_id         { Faker::Internet.password }
    name                { ['Paris', 'Lyon', 'Marseille'].sample }
    country_code        { 'FR' }

    association :country
  end
end
