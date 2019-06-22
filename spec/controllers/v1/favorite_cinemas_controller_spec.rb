require 'rails_helper'

RSpec.describe V1::FavoriteCinemasController, type: :controller do
  let(:cinema) { create(:cinema) }
  let(:bercy)  { create(:cinema, name: 'UGC Bercy') }
  let(:bibliotheque)  { create(:cinema, name: 'MK2 Bibliotheque') }
  let(:user)   { create(:user) }

  context 'when user is not authenticated' do
    describe '#index' do
      it 'returns 401 response' do
        get :index
        expect(response).to have_http_status '401'
      end
    end

    describe '#create' do
      it 'returns 401 response' do
        post :create, params: { id: cinema.id }
        expect(response).to have_http_status '401'
      end
    end

    describe '#destroy' do
      it 'returns 401 response' do
        delete :destroy, params: { id: cinema.id }
        expect(response).to have_http_status '401'
      end
    end
  end

  context 'when user is authenticated' do
    before do
      sign_in(user)
    end

    describe '#index' do
      before do
        create(:favorite_cinema, cinema: bercy, user: user)
        create(:favorite_cinema, cinema: bibliotheque, user: user)
      end

      context 'when q params is filled' do
        it 'filters favorite cinemas' do
          get :index, params: { q: 'bercy' }

          body = Oj.load response.body
          cinema_ids = body['data'].map { |x| x['id'].to_i }

          expect(cinema_ids).to match_array([bercy.id])
          expect(response).to have_http_status '200'
        end
      end

      context 'when q params is not filled' do
        it 'shows favorite cinemas list' do
          get :index
          body = Oj.load response.body
          cinema_ids = body['data'].map { |x| x['id'].to_i }

          expect(cinema_ids).to match_array([bercy.id, bibliotheque.id])
          expect(response).to have_http_status '200'
        end
      end
    end

    describe '#create' do
      it 'adds into favorite cinemas list' do
        expect {
         post :create, params: { id: cinema.id }
        }.to change(user.favorite_cinemas, :count).by(1)
        expect(response).to have_http_status '201'
      end
    end

    describe '#destroy' do
      it 'removes into favorite cinemas list' do
        create(:favorite_cinema, user: user, cinema: cinema)

        expect {
         delete :destroy, params: { id: cinema.id }
        }.to change(user.favorite_cinemas, :count).by(-1)
        expect(response).to have_http_status '204'
      end
    end
  end
end
