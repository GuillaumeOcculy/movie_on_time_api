FactoryBot.define do
  factory :genre do
    external_id         { Faker::Internet.password }
    name                { ['Paris', 'Lyon', 'Marseille'].sample }
  end
end
