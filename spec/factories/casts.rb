FactoryBot.define do
  factory :cast do
    name          { Faker::Name.name }
    character     { Faker::Movies::HarryPotter.character }
    external_id   { Faker::Alphanumeric.alphanumeric }

    association :movie
    association :person
  end
end
