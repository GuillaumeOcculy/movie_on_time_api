require 'rails_helper'

RSpec.describe Country, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:country)).to be_valid 
  end

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:language) }
  it { should validate_presence_of(:iso_code) }

  it { should have_many(:cities) }
end
