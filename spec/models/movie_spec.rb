require 'rails_helper'

RSpec.describe Movie, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:movie)).to be_valid 
  end

  it { should validate_presence_of(:external_id) }

  it { should have_many(:showtimes) }
  it { should have_many(:cinemas) }
  it { should have_many(:movie_countries) }
  it { should have_many(:countries) }
  it { should have_many(:movie_genres) }
  it { should have_many(:genres) }
  it { should have_many(:casts) }
  it { should have_many(:directors) }
  it { should have_many(:ratings) }
  it { should have_many(:trailers) }
  it { should have_many(:movie_translations) }
  it { should have_many(:watchlist_movies) }
  it { should have_many(:watchlisted_by_users) }
  it { should have_many(:watched_movies) }
  it { should have_many(:watched_by_users) }
end
