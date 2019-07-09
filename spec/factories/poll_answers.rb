FactoryBot.define do
  factory :poll_answer do
    poll nil
    body "MyText"
    vote_count 1
  end
end
