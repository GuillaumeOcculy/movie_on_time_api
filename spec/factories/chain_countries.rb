FactoryBot.define do
  factory :chain_country do
    association :chain
    association :country
  end
end
