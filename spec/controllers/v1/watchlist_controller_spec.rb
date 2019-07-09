require 'rails_helper'

RSpec.describe V1::WatchlistsController, type: :controller do
  let(:movie) { create(:movie, :with_french_release) }
  let(:jackie_brown) { create(:movie, :with_french_release, :with_translations, original_title: 'Jackie Brown') }
  let(:interstellar) { create(:movie, :with_french_release, :with_translations, original_title: 'Interstellar') }
  let(:user)  { create(:user) }

  context 'when user is not authenticated' do
    describe '#show' do
      it 'returns 401 response' do
        get :show
        expect(response).to have_http_status '401'
      end
    end

    describe '#create' do
      it 'returns 401 response' do
        post :create, params: { id: movie.id }
        expect(response).to have_http_status '401'
      end
    end

    describe '#destroy' do
      it 'returns 401 response' do
        delete :destroy, params: { id: movie.id }
        expect(response).to have_http_status '401'
      end
    end
  end

  context 'when user is authenticated' do
    before do
      sign_in(user)
    end

    describe '#show' do
      before do
        create(:watchlist_movie, user: user, movie: interstellar)
        create(:watchlist_movie, user: user, movie: jackie_brown)
      end

      context 'when q params is filled' do
        it 'filters watchlisted movies' do
          get :show, params: { q: 'interstellar' }

          body = Oj.load response.body
          movie_ids = body['data'].map { |x| x['id'].to_i }

          expect(movie_ids).to match_array([interstellar.id])
          expect(response).to have_http_status '200'
        end
      end

      context 'when q params is not filled' do
        it 'shows watchlisted movies list' do
          get :show
          body = Oj.load response.body
          movie_ids = body['data'].map { |x| x['id'].to_i }

          expect(movie_ids).to match_array([interstellar.id, jackie_brown.id])
          expect(response).to have_http_status '200'
        end
      end
    end

    describe '#create' do
      it 'adds into watchlisted movies list' do
        expect {
         post :create, params: { movie_id: movie.id }
        }.to change(user.watchlisted_movies, :count).by(1)
        expect(response).to have_http_status '201'
      end
    end

    describe '#destroy' do
      it 'removes into watchlisted movies list' do
        create(:watchlist_movie, user: user, movie: movie)

        expect {
         delete :destroy, params: { movie_id: movie.id }
        }.to change(user.watchlisted_movies, :count).by(-1)
        expect(response).to have_http_status '204'
      end
    end
  end
end
