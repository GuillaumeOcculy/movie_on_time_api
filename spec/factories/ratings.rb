FactoryBot.define do
  factory :rating do
    name        { Faker::Company.name }
    value       { Faker::Number.decimal(2) }
    vote_count  { Faker::Number.between(1, 5) }

    association :movie
  end
end
