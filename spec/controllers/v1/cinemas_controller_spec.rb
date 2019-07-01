require 'rails_helper'

RSpec.describe V1::CinemasController, type: :controller do
  let(:user) {create(:user)}

  before(:all) do
    Cinema.destroy_all
    @bercy = create(:cinema, name: 'UGC Bercy')
    @bibliotheque = create(:cinema, name: 'MK2 Bibliotheque')
    @surrey_quays = create(:cinema, :england, name: 'Surrey Quays')
    @whiteleys = create(:cinema, :england, name: 'Whiteleys')
  end

  describe '#show' do
    it 'responds successfully' do
      cinema = create(:cinema)
      get :show, params: { id: cinema.id }
      expect(response).to be_successful
    end
  end

  describe '#index' do
    it 'responds successfully' do
      get :index
      expect(response).to be_successful
    end

    context 'as an authenticated user' do

      before do
        user.update(country: 'GB')
        sign_in user
      end

      describe 'country setting is set to GB' do
        context 'when params :q is present' do
          it 'returns the queried english cinemas' do
            get :index, params: { q: 'surrey' }
            body = Oj.load response.body
            cinema_ids = body['data'].map { |x| x['id'].to_i }
            expect(cinema_ids).to match_array([@surrey_quays.id])
          end
        end

        context 'when params :q is absent' do
          it 'returns the english cinemas' do
            get :index
            body = Oj.load response.body
            cinema_ids = body['data'].map { |x| x['id'].to_i }
            expect(cinema_ids).to match_array([@surrey_quays.id, @whiteleys.id])
          end
        end
      end
    end

    context 'as guest' do
      context 'when params :q is present' do
        it 'returns the french queried cinemas' do
          get :index, params: { q: 'bercy' }
          body = Oj.load response.body
          cinema_ids = body['data'].map { |x| x['id'].to_i }
          expect(cinema_ids).to match_array([@bercy.id])
        end
      end

      context 'when params :q is absent' do
        it 'returns the french cinemas' do
          get :index
          body = Oj.load response.body
          cinema_ids = body['data'].map { |x| x['id'].to_i }
          expect(cinema_ids).to match_array([@bercy.id, @bibliotheque.id])
        end
      end
    end
  end
end
