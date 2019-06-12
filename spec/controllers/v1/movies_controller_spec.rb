require 'rails_helper'

RSpec.describe V1::MoviesController, type: :controller do
  let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) } 
  let(:cache) { Rails.cache }

  before do
    allow(Rails).to receive(:cache).and_return(memory_store)
    Rails.cache.clear
  end

  describe '#show' do
    it 'responds successfully' do
      @movie = create(:movie)
      get :show, params: { id: @movie.id }
      expect(response).to be_successful
    end
  end

  describe '#index' do
    before do
      @forrest_gump = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'Forrest Gump')
      @matrix = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'Matrix')
      @movie_old_showtimes = create(:movie, :with_old_showtimes, :with_french_release, :with_translations)
    end

    it 'responds successfully' do
      get :index
      expect(response).to be_successful
    end

    context 'when params :query is present' do
      it 'returns the queried live movies' do
        get :index, params: { query: 'forrest' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@forrest_gump.id.to_s])
      end
    end

    context 'when params :query is absent' do
      it 'returns the live movies' do
        get :index
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@forrest_gump.id.to_s, @matrix.id.to_s])
      end
    end
  end

  describe '#search' do
    before do
      @forrest_gump = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'Forrest Gump')
      @matrix = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'Matrix')
      @movie_old_showtimes = create(:movie, :with_old_showtimes, :with_french_release, :with_translations)
    end

    it 'responds successfully' do
      get :search
      expect(response).to be_successful
    end

    context 'when params :q is present' do
      it 'returns the queried live movies' do
        get :search, params: { q: 'forrest' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@forrest_gump.id.to_s])
      end
    end

    context 'when params :q is absent' do
      it 'returns the live movies' do
        get :search
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        ids = Movie.live.collect {|x| x['id'].to_s }
        expect(movie_ids).to match_array(ids)
      end
    end
  end

  describe '#premiere' do
    before do
      @remember_titans = create(:movie, :with_today_showtimes, :with_french_futur_release, :with_translations, original_title: 'Remember the Titans')
      @avengers = create(:movie, :with_today_showtimes, :with_french_futur_release, :with_translations, original_title: 'Matrix')
      @movie_old_showtimes = create(:movie, :with_showtimes, :with_french_futur_release, :with_translations)
    end

    it 'responds successfully' do
      get :premiere
      expect(response).to be_successful
    end

    context 'when params :query is present' do
      it 'returns the queried live movies' do
        get :premiere, params: { query: 'titans' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@remember_titans.id.to_s])
      end
    end

    context 'when params :query is absent' do
      it 'returns the live movies' do
        get :premiere
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@remember_titans.id.to_s, @avengers.id.to_s])
      end
    end
  end
end
