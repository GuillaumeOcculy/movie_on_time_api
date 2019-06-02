FactoryBot.define do
  factory :showtime do
    external_id       { Faker::Alphanumeric.alphanumeric }
    start_date        { Faker::Date.between(2.days.ago, Date.tomorrow) }
    start_at          { Time.new(start_date.year, start_date.month, start_date.day) }

    association :movie
    association :cinema
  end
end
