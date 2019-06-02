require 'rails_helper'

RSpec.describe Showtime, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:showtime)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:external_id) }
  it { is_expected.to validate_presence_of(:start_at) }
  it { is_expected.to validate_presence_of(:start_date) }

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to belong_to(:cinema) }
end
