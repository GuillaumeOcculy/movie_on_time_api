require 'rails_helper'

RSpec.describe MovieCountry, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:movie_country)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:iso_code) }

  it { is_expected.to belong_to(:movie) }
  it { is_expected.to belong_to(:country) }
end
