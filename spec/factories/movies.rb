FactoryBot.define do
  factory :movie do
    external_id         { Faker::Internet.password }
    original_title      { Faker::Book.title }
    original_language   { 'fr' }
    running_time        { [90, 120, 160, 180].sample }
  end
end
