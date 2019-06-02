FactoryBot.define do
  factory :trailer do
    url       { Faker::Internet.url('youtube.com') }
    format    { 'youtube' }
    language  { ['fr', 'en'].sample }

    association :movie
  end
end
