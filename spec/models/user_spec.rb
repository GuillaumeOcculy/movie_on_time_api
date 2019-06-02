require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }

  it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { is_expected.to have_many(:watchlist_movies) }
  it { is_expected.to have_many(:watchlisted_movies) }
  it { is_expected.to have_many(:watched_movies) }
  it { is_expected.to have_many(:movies_watched) }
  it { is_expected.to have_many(:favorite_cinemas) }
  it { is_expected.to have_many(:favorited_cinemas) }
  it { is_expected.to have_many(:notifications) }

  it 'returns a token' do
    expect(user.token).to_not be_empty
  end
end
