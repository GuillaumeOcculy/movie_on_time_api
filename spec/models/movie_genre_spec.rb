require 'rails_helper'

RSpec.describe MovieGenre, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:movie_genre)).to be_valid 
  end

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to belong_to(:genre) }
end
