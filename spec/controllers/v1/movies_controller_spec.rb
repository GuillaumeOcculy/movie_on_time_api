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

    context 'when params :q is present' do
      it 'returns the queried live movies' do
        get :index, params: { q: 'black' }
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@black_panther.id])
      end
    end

    context 'when params :q is absent' do
      it 'returns the live movies' do
        get :index
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@black_panther.id, @avengers.id])
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
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@black_panther.id])
      end
    end

    context 'when params :q is absent' do
      it 'returns all movies' do
        get :search
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        ids = Movie.live.collect {|x| x['id'].to_i }
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

    context 'when params :q is present' do
      it 'returns the queried upcoming movies', :focus do
        get :upcoming, params: { q: 'ant' }
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }

        expect(movie_ids).to match_array([@ant_man.id])
      end
    end

    context 'when params :q is absent' do
      it 'returns the upcoming movies' do
        get :upcoming
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@ant_man.id, @xmen.id])
      end
    end
  end

  describe '#premiere' do
    before do
      @lion_king = create(:movie, :with_today_showtimes, :with_french_futur_release, :with_translations, original_title: 'Roi Lion')
      @joker = create(:movie, :with_today_showtimes, :with_french_futur_release, :with_translations, original_title: 'Matrix')
      @movie_old_showtimes = create(:movie, :with_old_showtimes, :with_french_futur_release, :with_translations)
    end

    it 'responds successfully' do
      get :premiere
      expect(response).to be_successful
    end

    context 'when params :q is present' do
      it 'returns the queried premiere movies' do
        get :premiere, params: { q: 'lion' }
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@lion_king.id])
      end
    end

    context 'when params :q is absent' do
      it 'returns the premiere movies' do
        get :premiere
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@lion_king.id, @joker.id])
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

    context 'when params :q is present' do
      it 'returns the queried reprojection movies' do
        get :reprojection, params: { q: 'titans' }
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@remember_titans.id])
      end
    end

    context 'when params :q is absent' do
      it 'returns the reprojection movies' do
        get :reprojection
        body = Oj.load response.body
        movie_ids = body['data'].map { |x| x['id'].to_i }
        expect(movie_ids).to match_array([@remember_titans.id, @forrest_gump.id])
      end
    end
  end
end
