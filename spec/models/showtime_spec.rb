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

  describe '#start_time' do
    it 'returns the correct time' do
      showtime = build(:showtime, start_at: DateTime.new(2019, 1, 1, 10, 19))
      expect(showtime.start_time).to eq '10:19'
    end
  end

  describe '#end_time' do
    it 'returns the correct time' do
      showtime = build(:showtime, end_at: DateTime.new(2019, 1, 1, 19, 10))
      expect(showtime.end_time).to eq '19:10'
    end

    it 'returns the nil if end_at is absent' do
      showtime = build(:showtime)
      expect(showtime.end_time).to be_nil
    end
  end

  describe '#version' do
    it 'returns VF version' do
      showtime = build(:showtime, language: 'fr')
      expect(showtime.version).to eq 'VF'
    end

    it 'returns VO version' do
      showtime = build(:showtime, language: 'en')
      expect(showtime.version).to eq 'VO'
    end
  end
end
