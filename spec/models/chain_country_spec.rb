require 'rails_helper'

RSpec.describe ChainCountry, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:chain_country)).to be_valid 
  end

  it { is_expected.to belong_to(:chain) }
  it { is_expected.to belong_to(:country) }
end
