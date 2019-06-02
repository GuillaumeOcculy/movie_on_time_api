require 'rails_helper'

RSpec.describe WatchlistMovie, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:watchlist_movie)).to be_valid 
  end

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to belong_to(:user) }
end
