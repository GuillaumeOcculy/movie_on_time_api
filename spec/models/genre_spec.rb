require 'rails_helper'

RSpec.describe Genre, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:genre)).to be_valid
  end

  it { is_expected.to validate_presence_of(:external_id) }
  it { is_expected.to validate_presence_of(:name) }
end
