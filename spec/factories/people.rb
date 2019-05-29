FactoryBot.define do
  factory :person do
    name          { Faker::Name.name }
    external_id   { Faker::Alphanumeric.alphanumeric }
  end
end
