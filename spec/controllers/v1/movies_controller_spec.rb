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
      movie = create(:movie)
      get :show, params: { id: movie.id }
      expect(response).to be_successful
    end
  end

  describe '#index' do
    before do
      @black_panther = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'Black Panther')
      @avengers = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'avengers')
      @movie_old_showtimes = create(:movie, :with_old_showtimes, :with_french_release, :with_translations)
    end

    it 'responds successfully' do
      get :index
      expect(response).to be_successful
    end

    context 'when params :query is present' do
      it 'returns the queried live movies' do
        get :index, params: { query: 'black' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@black_panther.id.to_s])
      end
    end

    context 'when params :query is absent' do
      it 'returns the live movies' do
        get :index
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@black_panther.id.to_s, @avengers.id.to_s])
      end
    end
  end

  describe '#search' do
    before do
      @black_panther = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'Black Panther')
      @avengers = create(:movie, :with_showtimes, :with_french_release, :with_translations, original_title: 'avengers')
      @movie_old_showtimes = create(:movie, :with_old_showtimes, :with_french_release, :with_translations)
    end

    it 'responds successfully' do
      get :search
      expect(response).to be_successful
    end

    context 'when params :q is present' do
      it 'returns the queried movies' do
        get :search, params: { q: 'black' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@black_panther.id.to_s])
      end
    end

    context 'when params :q is absent' do
      it 'returns all movies' do
        get :search
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        ids = Movie.live.collect {|x| x['id'].to_s }
        expect(movie_ids).to match_array(ids)
      end
    end
  end

  describe '#upcoming' do
    before do
      @ant_man = create(:movie, :with_french_futur_release, :with_translations, original_title: 'Ant-Man')
      @xmen = create(:movie, :with_french_futur_release, :with_translations, original_title: 'X-Men')
    end

    it 'responds successfully' do
      get :upcoming
      expect(response).to be_successful
    end

    context 'when params :query is present' do
      it 'returns the queried upcoming movies' do
        get :upcoming, params: { query: 'ant' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@ant_man.id.to_s])
      end
    end

    context 'when params :query is absent' do
      it 'returns the upcoming movies' do
        get :upcoming
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@ant_man.id.to_s, @xmen.id.to_s])
      end
    end
  end

  describe '#premiere' do
    before do
      @lion_king = create(:movie, :with_today_showtimes, :with_french_futur_release, :with_translations, original_title: 'Roi Lion')
      @joker = create(:movie, :with_today_showtimes, :with_french_futur_release, :with_translations, original_title: 'Matrix')
      @movie_old_showtimes = create(:movie, :with_showtimes, :with_french_futur_release, :with_translations)
    end

    it 'responds successfully' do
      get :premiere
      expect(response).to be_successful
    end

    context 'when params :query is present' do
      it 'returns the queried premiere movies' do
        get :premiere, params: { query: 'lion' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@lion_king.id.to_s])
      end
    end

    context 'when params :query is absent' do
      it 'returns the premiere movies' do
        get :premiere
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@lion_king.id.to_s, @joker.id.to_s])
      end
    end
  end

  describe '#reprojection' do
    before do
      @remember_titans = create(:movie, :with_showtimes, :with_french_old_release, :with_translations, original_title: 'Remember the Titans')
      @forrest_gump = create(:movie, :with_showtimes, :with_french_old_release, :with_translations, original_title: 'Forrest Gump')
    end

    it 'responds successfully' do
      get :reprojection
      expect(response).to be_successful
    end

    context 'when params :query is present' do
      it 'returns the queried reprojection movies' do
        get :reprojection, params: { query: 'titans' }
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@remember_titans.id.to_s])
      end
    end

    context 'when params :query is absent' do
      it 'returns the reprojection movies' do
        get :reprojection
        body = JSON.parse response.body
        movie_ids = body['data'].map {|x| x['id']}
        expect(movie_ids).to match_array([@remember_titans.id.to_s, @forrest_gump.id.to_s])
      end
    end
  end
end
