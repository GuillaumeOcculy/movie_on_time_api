require 'rails_helper'

RSpec.describe WatchedMovie, type: :model do

  it "has a valid factory" do
    expect(build(:watched_movie)).to be_valid 
  end

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to belong_to(:user) }

  it 'saves watched_date to today if not specified' do
    watched_movie = create(:watched_movie, watched_date: nil)
    expect(watched_movie.watched_date).to eq Date.today
  end
end
