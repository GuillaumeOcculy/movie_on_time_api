FactoryBot.define do
  factory :user do
    first_name    { Faker::Name.first_name }
    last_name     { Faker::Name.last_name }
    email         { Faker::Internet.unique.email }
    password      { Faker::Internet.password }

    trait :invalid do
      email nil
    end
  end
end
