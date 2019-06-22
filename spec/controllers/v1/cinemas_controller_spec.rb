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

    context 'when params :q is present' do
      it 'returns the french queried live movies' do
        get :index, params: { q: 'bercy' }
        body = Oj.load response.body
        cinema_ids = body['data'].map { |x| x['id'].to_i }
        expect(cinema_ids).to match_array([@bercy.id])
      end
    end

    context 'when params :q is absent' do
      it 'returns the french live movies' do
        get :index
        body = Oj.load response.body
        cinema_ids = body['data'].map { |x| x['id'].to_i }
        expect(cinema_ids).to match_array([@bercy.id, @bibliotheque.id])
      end
    end
  end
end
