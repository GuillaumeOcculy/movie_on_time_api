require 'rails_helper'

RSpec.describe MovieTranslation, type: :model do

  it "has a valid factory" do
    expect(FactoryBot.build(:movie_translation)).to be_valid 
  end

  it { is_expected.to validate_presence_of(:language) }

  it { is_expected.to belong_to(:movie) }
end
