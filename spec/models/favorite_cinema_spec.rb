require 'rails_helper'

RSpec.describe FavoriteCinema, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:favorite_cinema)).to be_valid 
  end

  it { is_expected.to belong_to(:cinema) }
  it { is_expected.to belong_to(:user) }
end
