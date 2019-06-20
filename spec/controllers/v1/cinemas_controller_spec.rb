require 'rails_helper'

RSpec.describe V1::CinemasController, type: :controller do
  describe '#show' do
    it 'responds successfully' do
      cinema = create(:cinema)
      get :show, params: { id: cinema.id }
      expect(response).to be_successful
    end
  end

  describe '#index' do
    before do
      @bercy = create(:cinema, name: 'UGC Bercy')
      @bibliotheque = create(:cinema, name: 'MK2 Bibliotheque')
      @english_cinema = create(:cinema, country_code: 'GB')
    end

    it 'responds successfully' do
      get :index
      expect(response).to be_successful
    end

    context 'when params :query is present' do
      it 'returns the french queried live movies' do
        get :index, params: { query: 'bercy' }
        body = JSON.parse response.body
        cinema_ids = body['data'].map {|x| x['id']}
        expect(cinema_ids).to match_array([@bercy.id.to_s])
      end
    end

    context 'when params :query is absent' do
      it 'returns the french live movies' do
        get :index
        body = JSON.parse response.body
        cinema_ids = body['data'].map {|x| x['id']}
        expect(cinema_ids).to match_array([@bercy.id.to_s, @bibliotheque.id.to_s])
      end
    end
  end
end
