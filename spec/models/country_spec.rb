require 'rails_helper'

RSpec.describe Country, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:country)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:language) }
  it { is_expected.to validate_presence_of(:iso_code) }

  it { is_expected.to have_many(:cities) }
end
