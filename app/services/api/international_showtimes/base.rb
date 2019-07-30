module Api::InternationalShowtimes
  class Base
    include HTTParty

    base_uri Settings.international_showtimes.base_url

    def initialize
      @country = Country.find_or_create_by(name: 'France', iso_code: 'FR', language: 'fr')
      @options = {headers: {'Content-Type' => 'application/json', 'Accept' => 'application/json', 'X-API-Key' => Settings.international_showtimes.api_key}, format: :plain}
    end

    def genres
      JSON.parse(self.class.get('/genres', @options), symbolize_names: true)[:genres]
    end

    def cities
      JSON.parse(self.class.get('/cities', @options), symbolize_names: true)[:cities]
    end

    def chains
      JSON.parse(self.class.get('/chains', @options), symbolize_names: true)[:chains]
    end

    def cinema(id)
      JSON.parse(self.class.get("/cinemas/#{id}", @options), symbolize_names: true)[:cinema]
    end

    def cinemas
      JSON.parse(self.class.get('/cinemas', @options), symbolize_names: true)[:cinemas]
    end

    def search_movies(movie_title, lang: 'fr')
      @options[:query] = { search_query: movie_title, search_field: 'title', lang: lang }
      JSON.parse(self.class.get('/movies', @options), symbolize_names: true)[:movies]
    end

    def upcoming_movies(country: 'FR')
      @options[:query] = { release_date_from: Date.today, countries: country, include_upcomings: true }
      JSON.parse(self.class.get('/movies', @options), symbolize_names: true)[:movies].select{ |x| x[:id].present? }
    end

    def movie_details(id, lang)
      @options[:headers]['Accept-Language'] = lang
      JSON.parse(self.class.get("/movies/#{id}", @options), symbolize_names: true)[:movie]
    end

    def showtimes(cinema_id, options = {})
      @options[:query] = { cinema_id: cinema_id }
      JSON.parse(self.class.get('/showtimes', @options), symbolize_names: true)[:showtimes].select{|showtime| showtime[:cinema_id].present? && showtime[:movie_id].present? }
    end

    def showtime_details(id)
      JSON.parse(self.class.get("/showtimes/#{id}", @options), symbolize_names: true)
    end
  end
end
