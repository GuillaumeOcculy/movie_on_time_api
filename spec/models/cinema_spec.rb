require 'rails_helper'

RSpec.describe Cinema, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:cinema)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:external_id) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:showtimes) }
  it { is_expected.to have_many(:movies) }
  it { is_expected.to have_many(:favorite_cinemas) }
  it { is_expected.to have_many(:favorited_by_users) }
end
