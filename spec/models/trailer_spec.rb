require 'rails_helper'

RSpec.describe Trailer, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:trailer)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:language) }
  it { is_expected.to validate_presence_of(:format) }
  it { is_expected.to validate_presence_of(:url) }

  it { is_expected.to belong_to(:movie) }
end
