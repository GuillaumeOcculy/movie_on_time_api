module Api::Tmdb
  class Base
    include HTTParty

    base_uri Settings.tmdb.base_url

    def initialize
      @options = {query: { api_key: Settings.tmdb.api_key }, format: :plain}
    end

    # https://developers.themoviedb.org/3/movies/get-movie-details
    def movie_details(movie_id, params = {language: 'fr'})
      params[:append_to_response] = 'credits,images,videos'
      @options[:query].merge!(params)
      JSON.parse(self.class.get("/movie/#{movie_id}", @options), symbolize_names: true)
    end

    # https://developers.themoviedb.org/3/movies/get-movie-videos
    def movie_trailers(movie_id, params = {language: 'fr'})
      @options[:query].merge!({language: params[:language]})
      JSON.parse(self.class.get("/movie/#{movie_id}/videos", @options), symbolize_names: true)
    end
  end
end
