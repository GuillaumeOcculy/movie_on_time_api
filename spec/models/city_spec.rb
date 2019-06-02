require 'rails_helper'

RSpec.describe City, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:city)).to be_valid
  end

  it { is_expected.to validate_presence_of(:external_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:country_code) }

  it { is_expected.to belong_to(:country) }
end
