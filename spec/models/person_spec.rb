require 'rails_helper'

RSpec.describe Person, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:person)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:external_id) }
  it { is_expected.to validate_presence_of(:name) }
end
