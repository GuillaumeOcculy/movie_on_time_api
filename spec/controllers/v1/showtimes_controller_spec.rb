require 'rails_helper'

RSpec.describe V1::ShowtimesController, type: :controller do
  describe '#show' do
    it 'responds successfully' do
      showtime = create(:showtime)
      get :show, params: { id: showtime.id }
      expect(response).to be_successful
    end
  end
end
