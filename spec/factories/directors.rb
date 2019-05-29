FactoryBot.define do
  factory :director do
    name          { Faker::Name.name }
    external_id   { Faker::Alphanumeric.alphanumeric }

    association :movie
    association :person
  end
end
