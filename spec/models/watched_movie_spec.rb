require 'rails_helper'

RSpec.describe WatchedMovie, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:watched_movie)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:watched_date) }

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to belong_to(:user) }
end
