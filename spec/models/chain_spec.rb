require 'rails_helper'

RSpec.describe Chain, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:chain)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:external_id) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to have_many(:chain_countries) }
  it { is_expected.to have_many(:countries) }
  it { is_expected.to have_many(:cinemas) }
end
