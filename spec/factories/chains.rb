FactoryBot.define do
  factory :chain do
    name          { Faker::Name.name }
    external_id   { Faker::Alphanumeric.alphanumeric }
  end
end
