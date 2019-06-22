require 'rails_helper'

RSpec.describe V1::WatchedMoviesController, type: :controller do
  let(:movie) { create(:movie, :with_french_release) }
  let(:jackie_brown) { create(:movie, :with_french_release, :with_translations, original_title: 'Jackie Brown') }
  let(:interstellar) { create(:movie, :with_french_release, :with_translations, original_title: 'Interstellar') }
  let(:user)  { create(:user) }

  context 'when user is not authenticated' do
    describe '#index' do
      it 'returns 401 response' do
        get :index
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

    describe '#index' do
      before do
        create(:watched_movie, user: user, movie: interstellar)
        create(:watched_movie, user: user, movie: jackie_brown)
      end

      context 'when q params is filled' do
        it 'filters favorite movies' do
          get :index, params: { q: 'interstellar' }

          body = Oj.load response.body
          movie_ids = body['data'].map { |x| x['id'].to_i }

          expect(movie_ids).to match_array([interstellar.id])
          expect(response).to have_http_status '200'
        end
      end

      context 'when q params is not filled' do
        it 'shows favorite movies list' do
          get :index
          body = Oj.load response.body
          movie_ids = body['data'].map { |x| x['id'].to_i }

          expect(movie_ids).to match_array([interstellar.id, jackie_brown.id])
          expect(response).to have_http_status '200'
        end
      end
    end

    describe '#create' do
      it 'adds into favorite movies list' do
        expect {
         post :create, params: { id: movie.id }
        }.to change(user.watched_movies, :count).by(1)
        expect(response).to have_http_status '201'
      end
    end

    describe '#destroy' do
      it 'removes into favorite movies list' do
        create(:watched_movie, user: user, movie: movie)

        expect {
         delete :destroy, params: { id: movie.id }
        }.to change(user.watched_movies, :count).by(-1)
        expect(response).to have_http_status '204'
      end
    end
  end
end
