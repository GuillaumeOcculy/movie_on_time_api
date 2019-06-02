require 'rails_helper'

RSpec.describe Director, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:director)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:external_id) }
  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to belong_to(:person) }
end
