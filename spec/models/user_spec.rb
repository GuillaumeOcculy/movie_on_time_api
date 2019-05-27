require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid 
  end

  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }

  it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }

  it { should have_many(:watchlist_movies) }
  it { should have_many(:watchlisted_movies) }
  it { should have_many(:watched_movies) }
  it { should have_many(:movies_watched) }
  it { should have_many(:favorite_cinemas) }
  it { should have_many(:favorited_cinemas) }
  it { should have_many(:notifications) }

  it 'returns a token' do
    expect(user.token).to_not be_empty
  end
end
