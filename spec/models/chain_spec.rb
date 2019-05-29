require 'rails_helper'

RSpec.describe Chain, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:chain)).to be_valid 
  end

  it { should validate_presence_of(:external_id) }
  it { should validate_presence_of(:name) }

  it { should have_many(:chain_countries) }
  it { should have_many(:countries) }
  it { should have_many(:cinemas) }
end
