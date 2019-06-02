require 'rails_helper'

RSpec.describe Rating, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:rating)).to be_valid 
  end

  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:movie_id) }

  it { is_expected.to belong_to(:movie) }
end
