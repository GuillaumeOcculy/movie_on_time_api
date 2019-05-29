require 'rails_helper'

RSpec.describe Cast, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:cast)).to be_valid 
  end

  it { should validate_presence_of(:external_id) }
  it { should validate_presence_of(:name) }

  it { should belong_to(:movie) }
  it { should belong_to(:person) }
end
