require 'rails_helper'

RSpec.describe Cinema, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:cinema)).to be_valid 
  end

  it { should validate_presence_of(:external_id) }
  it { should validate_presence_of(:name) }

  it { should have_many(:showtimes) }
  it { should have_many(:movies) }
  it { should have_many(:favorite_cinemas) }
  it { should have_many(:favorited_by_users) }
end
